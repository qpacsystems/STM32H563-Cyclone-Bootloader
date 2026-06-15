cmake_minimum_required(VERSION 3.26)

set(PROJECT_NAME STM32H563-Cyclone-Bootloader)
project(${PROJECT_NAME} C ASM)
set(CMAKE_C_STANDARD 11)

# Cross-compile toolchain must be provided
if(NOT DEFINED CMAKE_TOOLCHAIN_FILE OR NOT CMAKE_TOOLCHAIN_FILE)
    message(FATAL_ERROR "CMAKE_TOOLCHAIN_FILE is required (arm-none-eabi-gcc or IAR toolchain)")
endif()

# Library paths (populated when creating GitHub repo)
set(CYCLONE_BOOT_PATH   "${CMAKE_CURRENT_SOURCE_DIR}/lib/cyclone_boot")
set(CYCLONE_CRYPTO_PATH "${CMAKE_CURRENT_SOURCE_DIR}/lib/cyclone_crypto")
set(CYCLONE_COMMON_PATH "${CMAKE_CURRENT_SOURCE_DIR}/lib/common")
set(STM32_HAL_PATH      "${CMAKE_CURRENT_SOURCE_DIR}/lib/STM32CubeH5/Drivers")

#---------------------------------------------------------------------------
# Compiler flags for Cortex-M33 bare-metal
#---------------------------------------------------------------------------
if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
    set(CPU_FLAGS "-mcpu=cortex-m33 -mthumb -mfloat-abi=soft")
    set(CMAKE_C_FLAGS   "${CMAKE_C_FLAGS} ${CPU_FLAGS} -fdata-sections -ffunction-sections -Wall -Wextra")
    set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} ${CPU_FLAGS}")
elseif(CMAKE_C_COMPILER_ID STREQUAL "IAR")
    # IAR flags are applied per-target below
endif()

add_compile_definitions(
    STM32H563xx
    USE_HAL_DRIVER
)

#---------------------------------------------------------------------------
# Include directories
#---------------------------------------------------------------------------
include_directories(src)

# STM32 HAL / CMSIS
include_directories(${STM32_HAL_PATH}/STM32H5xx_HAL_Driver/Inc)
include_directories(${STM32_HAL_PATH}/CMSIS/Device/ST/STM32H5xx/Include)
include_directories(${STM32_HAL_PATH}/CMSIS/Include)

# CycloneBOOT
include_directories(${CYCLONE_BOOT_PATH})
include_directories(${CYCLONE_BOOT_PATH}/core)
include_directories(${CYCLONE_BOOT_PATH}/bootloader)
include_directories(${CYCLONE_BOOT_PATH}/bootloader/second_stage)
include_directories(${CYCLONE_BOOT_PATH}/modules)
include_directories(${CYCLONE_BOOT_PATH}/modules/image)
include_directories(${CYCLONE_BOOT_PATH}/modules/memory)
include_directories(${CYCLONE_BOOT_PATH}/modules/security)
include_directories(${CYCLONE_BOOT_PATH}/drivers)
include_directories(${CYCLONE_BOOT_PATH}/drivers/mcu_core)
include_directories(${CYCLONE_BOOT_PATH}/drivers/flash)
include_directories(${CYCLONE_BOOT_PATH}/drivers/flash/internal)

# CycloneCRYPTO
include_directories(${CYCLONE_CRYPTO_PATH})
include_directories(${CYCLONE_CRYPTO_PATH}/core)
include_directories(${CYCLONE_CRYPTO_PATH}/hash)
include_directories(${CYCLONE_CRYPTO_PATH}/mac)

# Cyclone common (os_port, etc.)
include_directories(${CYCLONE_COMMON_PATH})

#---------------------------------------------------------------------------
# Source files
#---------------------------------------------------------------------------

# Bootloader application sources
set(SOURCES_APP
    src/main.c
    src/system_init.c
    src/boot_hooks.c
)

# CycloneBOOT v2.6.2 second-stage bootloader
set(SOURCES_CYCLONE_BOOT
    ${CYCLONE_BOOT_PATH}/bootloader/second_stage/boot.c
    ${CYCLONE_BOOT_PATH}/bootloader/second_stage/boot_common.c
    ${CYCLONE_BOOT_PATH}/bootloader/second_stage/boot_fallback.c
    ${CYCLONE_BOOT_PATH}/core/crc32.c
    ${CYCLONE_BOOT_PATH}/core/mailbox.c
    ${CYCLONE_BOOT_PATH}/core/verify.c
    ${CYCLONE_BOOT_PATH}/drivers/flash/internal/stm32h5xx_flash_driver.c
    ${CYCLONE_BOOT_PATH}/drivers/mcu_core/stm32h5xx_mcu_driver.c
    ${CYCLONE_BOOT_PATH}/modules/image/image.c
    ${CYCLONE_BOOT_PATH}/modules/image/image_process.c
    ${CYCLONE_BOOT_PATH}/modules/image/image_utils.c
    ${CYCLONE_BOOT_PATH}/modules/memory/memory.c
    ${CYCLONE_BOOT_PATH}/modules/memory/memory_ex.c
)

# CycloneCRYPTO (for CRC32 hash algo interface + SHA256 if needed)
set(SOURCES_CYCLONE_CRYPTO
    ${CYCLONE_CRYPTO_PATH}/hash/sha256.c
    ${CYCLONE_CRYPTO_PATH}/mac/hmac.c
)

# Cyclone common (bare-metal OS port)
set(SOURCES_CYCLONE_COMMON
    ${CYCLONE_COMMON_PATH}/os_port_none.c
    ${CYCLONE_COMMON_PATH}/debug.c
)

# Minimal STM32 HAL subset (no RTOS, no networking)
set(SOURCES_STM32_HAL
    ${STM32_HAL_PATH}/STM32H5xx_HAL_Driver/Src/stm32h5xx_hal.c
    ${STM32_HAL_PATH}/STM32H5xx_HAL_Driver/Src/stm32h5xx_hal_cortex.c
    ${STM32_HAL_PATH}/STM32H5xx_HAL_Driver/Src/stm32h5xx_hal_flash.c
    ${STM32_HAL_PATH}/STM32H5xx_HAL_Driver/Src/stm32h5xx_hal_flash_ex.c
    ${STM32_HAL_PATH}/STM32H5xx_HAL_Driver/Src/stm32h5xx_hal_gpio.c
    ${STM32_HAL_PATH}/STM32H5xx_HAL_Driver/Src/stm32h5xx_hal_icache.c
    ${STM32_HAL_PATH}/STM32H5xx_HAL_Driver/Src/stm32h5xx_hal_pwr.c
    ${STM32_HAL_PATH}/STM32H5xx_HAL_Driver/Src/stm32h5xx_hal_pwr_ex.c
    ${STM32_HAL_PATH}/STM32H5xx_HAL_Driver/Src/stm32h5xx_hal_rcc.c
    ${STM32_HAL_PATH}/STM32H5xx_HAL_Driver/Src/stm32h5xx_hal_rcc_ex.c
)

#---------------------------------------------------------------------------
# Compiler-specific startup and build target
#---------------------------------------------------------------------------
set(BINARY_NAME "bootloader")

if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
    #-----------------------------------------------------------------------
    # GCC build
    #-----------------------------------------------------------------------
    set(SOURCES_STARTUP startup/boot.gcc.s)
    set(LINKER_SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/linker/bootloader_flash.ld")

    add_executable(${BINARY_NAME}
        ${SOURCES_APP}
        ${SOURCES_CYCLONE_BOOT}
        ${SOURCES_CYCLONE_CRYPTO}
        ${SOURCES_CYCLONE_COMMON}
        ${SOURCES_STM32_HAL}
        ${SOURCES_STARTUP}
    )

    target_link_options(${BINARY_NAME} PRIVATE
        -T${LINKER_SCRIPT}
        -Wl,--gc-sections
        -Wl,--print-memory-usage
        --specs=nosys.specs
        --specs=nano.specs
        -lc
        -lm
        -lnosys
    )

    # Post-build: generate .bin and .hex, print size
    add_custom_command(TARGET ${BINARY_NAME} POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${BINARY_NAME}> ${CMAKE_BINARY_DIR}/bootloader.bin
        COMMAND ${CMAKE_OBJCOPY} -O ihex   $<TARGET_FILE:${BINARY_NAME}> ${CMAKE_BINARY_DIR}/bootloader.hex
        COMMAND ${CMAKE_SIZE}    $<TARGET_FILE:${BINARY_NAME}>
        COMMENT "Generating bootloader.bin and bootloader.hex"
    )

elseif(CMAKE_C_COMPILER_ID STREQUAL "IAR")
    #-----------------------------------------------------------------------
    # IAR build
    #-----------------------------------------------------------------------
    set(SOURCES_STARTUP startup/boot.iar.s)
    set(LINKER_SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/linker/bootloader_flash.icf")

    add_executable(${BINARY_NAME}
        ${SOURCES_APP}
        ${SOURCES_CYCLONE_BOOT}
        ${SOURCES_CYCLONE_CRYPTO}
        ${SOURCES_CYCLONE_COMMON}
        ${SOURCES_STM32_HAL}
        ${SOURCES_STARTUP}
        ${LINKER_SCRIPT}
    )

    target_compile_options(${BINARY_NAME} PRIVATE
        $<$<COMPILE_LANGUAGE:C>:--dlib_config=full -e --cpu Cortex-M33 --fpu=VFPv5-SP>
        $<$<COMPILE_LANGUAGE:ASM>:--cpu Cortex-M33 --fpu=VFPv5-SP>
    )

    target_link_options(${BINARY_NAME} PRIVATE
        --semihosting
        --config ${LINKER_SCRIPT}
    )

    # Post-build: generate .bin and .hex via ielftool
    find_program(IAR_ELF_TOOL ielftool)
    if(IAR_ELF_TOOL)
        add_custom_command(TARGET ${BINARY_NAME} POST_BUILD
            COMMAND ${IAR_ELF_TOOL} --bin $<TARGET_FILE:${BINARY_NAME}> ${CMAKE_BINARY_DIR}/bootloader.bin
            COMMAND ${IAR_ELF_TOOL} --ihex $<TARGET_FILE:${BINARY_NAME}> ${CMAKE_BINARY_DIR}/bootloader.hex
            COMMENT "Generating bootloader.bin and bootloader.hex (IAR)"
        )
    endif()

else()
    message(FATAL_ERROR "Unsupported compiler: ${CMAKE_C_COMPILER_ID}. Use GCC or IAR.")
endif()
