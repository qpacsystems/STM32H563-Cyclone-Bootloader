
;********************************************************************************
;* File Name          : startup_stm32h563xx.s
;* Author             : MCD Application Team
;* Description        : STM32H563xx Non Crypto Devices vector
;*                      This module performs:
;*                      - Set the initial SP
;*                      - Set the initial PC == _iar_program_start,
;*                      - Set the vector table entries with the exceptions ISR
;*                        address.
;*                      - Branches to main in the C library (which eventually
;*                        calls main()).
;*                      After Reset the Cortex-M33 processor is in Thread mode,
;*                      priority is Privileged, and the Stack is set to Main.
;********************************************************************************
;* @attention
;*
;* Copyright (c) 2023 STMicroelectronics.
;* All rights reserved.
;*
;* This software is licensed under terms that can be found in the LICENSE file
;* in the root directory of this software component.
;* If no LICENSE file comes with this software, it is provided AS-IS.
;*
;*******************************************************************************
;
;
; The modules in this file are included in the libraries, and may be replaced
; by any user-defined modules that define the PUBLIC symbol _program_start or
; a user defined start symbol.
; To override the cstartup defined in the library, simply add your modified
; version to the workbench project.
;
; The vector table is normally located at address 0.
; When debugging in RAM, it can be located in RAM, aligned to at least 2^6.
; The name "__vector_table" has special meaning for C-SPY:
; it is where the SP start value is found, and the NVIC vector
; table register (VTOR) is initialized to this address if != 0.
;
; Cortex-M version
;

        MODULE  ?cstartup

        ;; Forward declaration of sections.
        SECTION CSTACK:DATA:NOROOT(3)

        SECTION .intvec:CODE:NOROOT(2)

        EXTERN  __iar_program_start
        EXTERN  SystemInit

        PUBLIC  __vector_table
        PUBLIC  __Vectors
        PUBLIC  __Vectors_End
        PUBLIC  __Vectors_Size

        DATA
__vector_table
        DCD     sfe(CSTACK)
        DCD     Reset_Handler                    ;  -15 : Reset Handler

        DCD     NMI_Handler                      ; -14 : NMI Handler
        DCD     HardFault_Handler            ; -13 : Hard Fault Handler
        DCD     MemManage_Handler                ; -12 : MPU Fault Handler
        DCD     BusFault_Handler                 ; -11 : Bus Fault Handler
        DCD     UsageFault_Handler               ; -10 : Usage Fault Handler
        DCD     SecureFault_Handler              ;  -9 : Secure Fault Handler
        DCD     0                                ;  -8 : Reserved
        DCD     0                                ;  -7 : Reserved
        DCD     0                                ;  -6 : Reserved
        DCD     SVC_Handler                      ;  -5 : SVCall Handler
        DCD     DebugMon_Handler                 ;  -4 : Debug Monitor Handler
        DCD     0                                ;  -3 : Reserved
        DCD     PendSV_Handler                   ;  -2 : PendSV Handler
        DCD     SysTick_Handler                  ;  -1 : SysTick Handler

         ; External Interrupts
        DCD     WWDG_IRQHandler                  ;   0 : Window WatchDog
        DCD     PVD_AVD_IRQHandler               ;   1 : PVD/AVD through EXTI Line detection Interrupt
        DCD     RTC_IRQHandler                   ;   2 : RTC non-secure interrupt
        DCD     RTC_S_IRQHandler                 ;   3 : RTC secure interrupt
        DCD     TAMP_IRQHandler                  ;   4 : Tamper non-secure interrupt
        DCD     RAMCFG_IRQHandler                ;   5 : RAMCFG global
        DCD     FLASH_IRQHandler                 ;   6 : FLASH non-secure global interrupt
        DCD     FLASH_S_IRQHandler               ;   7 : FLASH secure global interrupt
        DCD     GTZC_IRQHandler                  ;   8 : Global TrustZone Controller interrupt
        DCD     RCC_IRQHandler                   ;   9 : RCC non-secure global interrupt
        DCD     RCC_S_IRQHandler                 ;  10 :  RCC secure global interrupt
        DCD     EXTI0_IRQHandler                 ;  11 :  EXTI Line0 interrupt
        DCD     EXTI1_IRQHandler                 ;  12 :  EXTI Line1 interrupt
        DCD     EXTI2_IRQHandler                 ;  13 :  EXTI Line2 interrupt
        DCD     EXTI3_IRQHandler                 ;  14 :  EXTI Line3 interrupt
        DCD     EXTI4_IRQHandler                 ;  15 :  EXTI Line4 interrupt
        DCD     EXTI5_IRQHandler                 ;  16 :  EXTI Line5 interrupt
        DCD     EXTI6_IRQHandler                 ;  17 :  EXTI Line6 interrupt
        DCD     EXTI7_IRQHandler                 ;  18 :  EXTI Line7 interrupt
        DCD     EXTI8_IRQHandler                 ;  19 :  EXTI Line8 interrupt
        DCD     EXTI9_IRQHandler                 ;  20 :  EXTI Line9 interrupt
        DCD     EXTI10_IRQHandler                ;  21 :  EXTI Line10 interrupt
        DCD     EXTI11_IRQHandler                ;  22 :  EXTI Line11 interrupt
        DCD     EXTI12_IRQHandler                ;  23 :  EXTI Line12 interrupt
        DCD     EXTI13_IRQHandler                ;  24 :  EXTI Line13 interrupt
        DCD     EXTI14_IRQHandler                ;  25 :  EXTI Line14 interrupt
        DCD     EXTI15_IRQHandler                ;  26 :  EXTI Line15 interrupt
        DCD     GPDMA1_Channel0_IRQHandler   ;  27 :  GPDMA1 Channel 0 global interrupt
        DCD     GPDMA1_Channel1_IRQHandler   ;  28 :  GPDMA1 Channel 1 global interrupt
        DCD     GPDMA1_Channel2_IRQHandler   ;  29 :  GPDMA1 Channel 2 global interrupt
        DCD     GPDMA1_Channel3_IRQHandler   ;  30 :  GPDMA1 Channel 3 global interrupt
        DCD     GPDMA1_Channel4_IRQHandler   ;  31 :  GPDMA1 Channel 4 global interrupt
        DCD     GPDMA1_Channel5_IRQHandler   ;  32 :  GPDMA1 Channel 5 global interrupt
        DCD     GPDMA1_Channel6_IRQHandler   ;  33 :  GPDMA1 Channel 6 global interrupt
        DCD     GPDMA1_Channel7_IRQHandler       ;  34 :  GPDMA1 Channel 7 global interrupt
        DCD     IWDG_IRQHandler                  ;  35 :  IWDG global interrupt
        DCD     0                                ;        Reserved
        DCD     ADC1_IRQHandler                  ;  37 :  ADC1 global interrupt
        DCD     DAC1_IRQHandler                  ;  38 :  DAC1 global interrupt
        DCD     FDCAN1_IT0_IRQHandler            ;  39 :  FDCAN1 interrupt 0
        DCD     FDCAN1_IT1_IRQHandler            ;  40 :  FDCAN1 interrupt 1
        DCD     TIM1_BRK_IRQHandler              ;  41 :  TIM1 Break interrupt
        DCD     TIM1_UP_IRQHandler               ;  42 :  TIM1 Update interrupt
        DCD     TIM1_TRG_COM_IRQHandler          ;  43 :  TIM1 Trigger and Commutation interrupt
        DCD     TIM1_CC_IRQHandler               ;  44 :  TIM1 Capture Compare interrupt
        DCD     TIM2_IRQHandler                  ;  45 :  TIM2 global interrupt
        DCD     TIM3_IRQHandler                  ;  46 :  TIM3 global interrupt
        DCD     TIM4_IRQHandler                  ;  47 :  TIM4 global interrupt
        DCD     TIM5_IRQHandler                  ;  48 :  TIM5 global interrupt
        DCD     TIM6_IRQHandler              ;  49 :  TIM6 global interrupt
        DCD     TIM7_IRQHandler                  ;  50 :  TIM7 global interrupt
        DCD     I2C1_EV_IRQHandler               ;  51 :  I2C1 Event interrupt
        DCD     I2C1_ER_IRQHandler               ;  52 :  I2C1 Error interrupt
        DCD     I2C2_EV_IRQHandler               ;  53 :  I2C2 Event interrupt
        DCD     I2C2_ER_IRQHandler               ;  54 :  I2C2 Error interrupt
        DCD     SPI1_IRQHandler                  ;  55 :  SPI1 global interrupt
        DCD     SPI2_IRQHandler              ;  56 :  SPI2 global interrupt
        DCD     SPI3_IRQHandler                  ;  57 :  SPI3 global interrupt
        DCD     USART1_IRQHandler            ;  58 :  USART1 global interrupt
        DCD     USART2_IRQHandler                ;  59 :  USART2 global interrupt
        DCD     USART3_IRQHandler            ;  60 :  USART3 global interrupt
        DCD     UART4_IRQHandler                 ;  61 :  UART4 global interrupt
        DCD     UART5_IRQHandler                 ;  62 :  UART5 global interrupt
        DCD     LPUART1_IRQHandler               ;  63 :  LPUART1 global interrupt
        DCD     LPTIM1_IRQHandler                ;  64 :  LPTIM1 global interrupt
        DCD     TIM8_BRK_IRQHandler              ;  65 :  TIM8 Break interrupt
        DCD     TIM8_UP_IRQHandler               ;  66 :  TIM8 Update interrupt
        DCD     TIM8_TRG_COM_IRQHandler          ;  67 :  TIM8 Trigger and Commutation interrupt
        DCD     TIM8_CC_IRQHandler               ;  68 :  TIM8 Capture Compare interrupt
        DCD     ADC2_IRQHandler                  ;  69 :  ADC2 global interrupt
        DCD     LPTIM2_IRQHandler                ;  70 :  LPTIM2 global interrupt
        DCD     TIM15_IRQHandler                 ;  71 :  TIM15 global interrupt
        DCD     TIM16_IRQHandler                 ;  72 :  TIM16 global interrupt
        DCD     TIM17_IRQHandler                 ;  73 :  TIM17 global interrupt
        DCD     USB_DRD_FS_IRQHandler            ;  74 :  USB DRD FS global interrupt
        DCD     CRS_IRQHandler                   ;  75 :  CRS global interrupt
        DCD     UCPD1_IRQHandler                 ;  76 :  UCPD1 global interrupt
        DCD     FMC_IRQHandler                   ;  77 :  FMC global interrupt
        DCD     OCTOSPI1_IRQHandler              ;  78 :  OctoSPI1 global interrupt
        DCD     SDMMC1_IRQHandler                ;  79 :  SDMMC1 global interrupt
        DCD     I2C3_EV_IRQHandler               ;  80 :  I2C2 Event interrupt
        DCD     I2C3_ER_IRQHandler               ;  81 :  I2C2 Error interrupt
        DCD     SPI4_IRQHandler              ;  82 :  SPI4 global interrupt
        DCD     SPI5_IRQHandler                  ;  83 :  SPI5 global interrupt
        DCD     SPI6_IRQHandler              ;  84 :  SPI6 global interrupt
        DCD     USART6_IRQHandler                ;  85 :  USART6 global interrupt
        DCD     USART10_IRQHandler               ;  86 :  USART10 global interrupt
        DCD     USART11_IRQHandler               ;  87 :  USART11 global interrupt
        DCD     SAI1_IRQHandler                  ;  88 :  Serial Audio Interface 1 global interrupt
        DCD     SAI2_IRQHandler                  ;  89 :  Serial Audio Interface 2 global interrupt
        DCD     GPDMA2_Channel0_IRQHandler       ;  90 :  GPDMA2 Channel 0 global interrupt
        DCD     GPDMA2_Channel1_IRQHandler       ;  91 :  GPDMA2 Channel 1 global interrupt
        DCD     GPDMA2_Channel2_IRQHandler       ;  92 :  GPDMA2 Channel 2 global interrupt
        DCD     GPDMA2_Channel3_IRQHandler       ;  93 :  GPDMA2 Channel 3 global interrupt
        DCD     GPDMA2_Channel4_IRQHandler       ;  94 :  GPDMA2 Channel 4 global interrupt
        DCD     GPDMA2_Channel5_IRQHandler       ;  95 :  GPDMA2 Channel 5 global interrupt
        DCD     GPDMA2_Channel6_IRQHandler       ;  96 :  GPDMA2 Channel 6 global interrupt
        DCD     GPDMA2_Channel7_IRQHandler       ;  97 :  GPDMA2 Channel 7 global interrupt
        DCD     UART7_IRQHandler                 ;  98 :  UART7 global interrupt
        DCD     UART8_IRQHandler                 ;  99 :  UART8 global interrupt
        DCD     UART9_IRQHandler                 ; 100 :  UART9 global interrupt
        DCD     UART12_IRQHandler                ; 101 :  UART12 global interrupt
        DCD     SDMMC2_IRQHandler                ; 102 :  SDMMC2 global interrupt
        DCD     FPU_IRQHandler               ; 103 :  FPU global interrupt
        DCD     ICACHE_IRQHandler                ; 104 :  Instruction cache global interrupt
        DCD     DCACHE1_IRQHandler               ; 105 :  DCACHE1 global interrupt
        DCD     ETH_IRQHandler                   ; 106 :  Ethernet global interrupt
        DCD     ETH_WKUP_IRQHandler              ; 107 :  Ethernet Wakeup global interrupt
        DCD     DCMI_PSSI_IRQHandler             ; 108 :  DCMI PSSI global interrupt
        DCD     FDCAN2_IT0_IRQHandler            ; 109 :  FDCAN2 interrupt 0
        DCD     FDCAN2_IT1_IRQHandler            ; 110 :  FDCAN2 interrupt 1
        DCD     CORDIC_IRQHandler                ; 111 :  CORDIC global interrupt
        DCD     FMAC_IRQHandler                  ; 112 :  FMAC global interrupt
        DCD     DTS_IRQHandler                   ; 113 :  DTS global interrupt
        DCD     RNG_IRQHandler               ; 114 :  RNG global interrupt
        DCD     0                                ;        Reserved
        DCD     0                                ;        Reserved
        DCD     HASH_IRQHandler                  ; 117 :  HASH global interrupt
        DCD     0                                ; 118 :  Reserved
        DCD     CEC_IRQHandler                   ; 119 :  CEC global interrupt
        DCD     TIM12_IRQHandler                 ; 120 :  TIM12 global interrupt
        DCD     TIM13_IRQHandler                 ; 121 :  TIM13 global interrupt
        DCD     TIM14_IRQHandler                 ; 122 :  TIM14 global interrupt
        DCD     I3C1_EV_IRQHandler               ; 123 :  I3C1 Event interrupt
        DCD     I3C1_ER_IRQHandler               ; 124 :  I3C1 Error interrupt
        DCD     I2C4_EV_IRQHandler               ; 125 :  I2C4 Event interrupt
        DCD     I2C4_ER_IRQHandler               ; 126 :  I2C4 Error interrupt
        DCD     LPTIM3_IRQHandler                ; 127 :  LPTIM3 global interrupt
        DCD     LPTIM4_IRQHandler                ; 128 :  LPTIM4 global interrupt
        DCD     LPTIM5_IRQHandler                ; 129 :  LPTIM5 global interrupt
        DCD     LPTIM6_IRQHandler                ; 130 :  LPTIM6 global interrupt

__Vectors_End

__Vectors       EQU   __vector_table
__Vectors_Size  EQU   __Vectors_End - __Vectors

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default interrupt handlers.
;;
        THUMB
        PUBWEAK Reset_Handler
        SECTION .text:CODE:NOROOT:REORDER(2)
Reset_Handler
        LDR     R0, =SystemInit
        BLX     R0
        LDR     R0, =__iar_program_start
        BX      R0

        PUBWEAK NMI_Handler
        SECTION .text:CODE:NOROOT:REORDER(1)
NMI_Handler
        B NMI_Handler

        PUBWEAK HardFault_Handler
        SECTION .text:CODE:NOROOT:REORDER(1)
HardFault_Handler
        B HardFault_Handler

        PUBWEAK MemManage_Handler
        SECTION .text:CODE:NOROOT:REORDER(1)
MemManage_Handler
        B MemManage_Handler

        PUBWEAK BusFault_Handler
        SECTION .text:CODE:NOROOT:REORDER(1)
BusFault_Handler
        B BusFault_Handler

        PUBWEAK UsageFault_Handler
        SECTION .text:CODE:NOROOT:REORDER(1)
UsageFault_Handler
        B UsageFault_Handler

        PUBWEAK SecureFault_Handler
        SECTION .text:CODE:NOROOT:REORDER(1)
SecureFault_Handler
        B SecureFault_Handler

        PUBWEAK SVC_Handler
        SECTION .text:CODE:NOROOT:REORDER(1)
SVC_Handler
        B SVC_Handler

        PUBWEAK DebugMon_Handler
        SECTION .text:CODE:NOROOT:REORDER(1)
DebugMon_Handler
        B DebugMon_Handler

        PUBWEAK PendSV_Handler
        SECTION .text:CODE:NOROOT:REORDER(1)
PendSV_Handler
        B PendSV_Handler

        PUBWEAK SysTick_Handler
        SECTION .text:CODE:NOROOT:REORDER(1)
SysTick_Handler
        B SysTick_Handler

        PUBWEAK WWDG_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
WWDG_IRQHandler
        B WWDG_IRQHandler

        PUBWEAK PVD_AVD_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
PVD_AVD_IRQHandler
        B PVD_AVD_IRQHandler

        PUBWEAK RTC_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
RTC_IRQHandler
        B RTC_IRQHandler

        PUBWEAK RTC_S_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
RTC_S_IRQHandler
        B RTC_S_IRQHandler

        PUBWEAK TAMP_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TAMP_IRQHandler
        B TAMP_IRQHandler

        PUBWEAK RAMCFG_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
RAMCFG_IRQHandler
        B RAMCFG_IRQHandler

        PUBWEAK FLASH_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
FLASH_IRQHandler
        B FLASH_IRQHandler

        PUBWEAK FLASH_S_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
FLASH_S_IRQHandler
        B FLASH_S_IRQHandler

        PUBWEAK GTZC_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GTZC_IRQHandler
        B GTZC_IRQHandler

        PUBWEAK RCC_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
RCC_IRQHandler
        B RCC_IRQHandler

        PUBWEAK RCC_S_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
RCC_S_IRQHandler
        B RCC_S_IRQHandler

        PUBWEAK EXTI0_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI0_IRQHandler
        B EXTI0_IRQHandler

        PUBWEAK EXTI1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI1_IRQHandler
        B EXTI1_IRQHandler

        PUBWEAK EXTI2_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI2_IRQHandler
        B EXTI2_IRQHandler

        PUBWEAK EXTI3_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI3_IRQHandler
        B EXTI3_IRQHandler

        PUBWEAK EXTI4_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI4_IRQHandler
        B EXTI4_IRQHandler

        PUBWEAK EXTI5_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI5_IRQHandler
        B EXTI5_IRQHandler

        PUBWEAK EXTI6_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI6_IRQHandler
        B EXTI6_IRQHandler

        PUBWEAK EXTI7_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI7_IRQHandler
        B EXTI7_IRQHandler

        PUBWEAK EXTI8_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI8_IRQHandler
        B EXTI8_IRQHandler

        PUBWEAK EXTI9_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI9_IRQHandler
        B EXTI9_IRQHandler

        PUBWEAK EXTI10_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI10_IRQHandler
        B EXTI10_IRQHandler

        PUBWEAK EXTI11_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI11_IRQHandler
        B EXTI11_IRQHandler

        PUBWEAK EXTI12_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI12_IRQHandler
        B EXTI12_IRQHandler

        PUBWEAK EXTI13_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI13_IRQHandler
        B EXTI13_IRQHandler

        PUBWEAK EXTI14_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI14_IRQHandler
        B EXTI14_IRQHandler

        PUBWEAK EXTI15_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
EXTI15_IRQHandler
        B EXTI15_IRQHandler

        PUBWEAK GPDMA1_Channel0_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GPDMA1_Channel0_IRQHandler
        B GPDMA1_Channel0_IRQHandler

        PUBWEAK GPDMA1_Channel1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GPDMA1_Channel1_IRQHandler
        B GPDMA1_Channel1_IRQHandler

        PUBWEAK GPDMA1_Channel2_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GPDMA1_Channel2_IRQHandler
        B GPDMA1_Channel2_IRQHandler

        PUBWEAK GPDMA1_Channel3_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GPDMA1_Channel3_IRQHandler
        B GPDMA1_Channel3_IRQHandler

        PUBWEAK GPDMA1_Channel4_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GPDMA1_Channel4_IRQHandler
        B GPDMA1_Channel4_IRQHandler

        PUBWEAK GPDMA1_Channel5_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GPDMA1_Channel5_IRQHandler
        B GPDMA1_Channel5_IRQHandler

        PUBWEAK GPDMA1_Channel6_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GPDMA1_Channel6_IRQHandler
        B GPDMA1_Channel6_IRQHandler

        PUBWEAK GPDMA1_Channel7_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GPDMA1_Channel7_IRQHandler
        B GPDMA1_Channel7_IRQHandler

        PUBWEAK IWDG_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
IWDG_IRQHandler
        B IWDG_IRQHandler

        PUBWEAK ADC1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
ADC1_IRQHandler
        B ADC1_IRQHandler

        PUBWEAK DAC1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
DAC1_IRQHandler
        B DAC1_IRQHandler

        PUBWEAK FDCAN1_IT0_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
FDCAN1_IT0_IRQHandler
        B FDCAN1_IT0_IRQHandler

        PUBWEAK FDCAN1_IT1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
FDCAN1_IT1_IRQHandler
        B FDCAN1_IT1_IRQHandler

        PUBWEAK TIM1_BRK_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM1_BRK_IRQHandler
        B TIM1_BRK_IRQHandler

        PUBWEAK TIM1_UP_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM1_UP_IRQHandler
        B TIM1_UP_IRQHandler

        PUBWEAK TIM1_TRG_COM_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM1_TRG_COM_IRQHandler
        B TIM1_TRG_COM_IRQHandler

        PUBWEAK TIM1_CC_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM1_CC_IRQHandler
        B TIM1_CC_IRQHandler

        PUBWEAK TIM2_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM2_IRQHandler
        B TIM2_IRQHandler

        PUBWEAK TIM3_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM3_IRQHandler
        B TIM3_IRQHandler

        PUBWEAK TIM4_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM4_IRQHandler
        B TIM4_IRQHandler

        PUBWEAK TIM5_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM5_IRQHandler
        B TIM5_IRQHandler

        PUBWEAK TIM6_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM6_IRQHandler
        B TIM6_IRQHandler

        PUBWEAK TIM7_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM7_IRQHandler
        B TIM7_IRQHandler

        PUBWEAK I2C1_EV_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
I2C1_EV_IRQHandler
        B I2C1_EV_IRQHandler

        PUBWEAK I2C1_ER_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
I2C1_ER_IRQHandler
        B I2C1_ER_IRQHandler

        PUBWEAK I2C2_EV_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
I2C2_EV_IRQHandler
        B I2C2_EV_IRQHandler

        PUBWEAK I2C2_ER_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
I2C2_ER_IRQHandler
        B I2C2_ER_IRQHandler

        PUBWEAK SPI1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
SPI1_IRQHandler
        B SPI1_IRQHandler

        PUBWEAK SPI2_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
SPI2_IRQHandler
        B SPI2_IRQHandler

        PUBWEAK SPI3_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
SPI3_IRQHandler
        B SPI3_IRQHandler

        PUBWEAK USART1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
USART1_IRQHandler
        B USART1_IRQHandler

        PUBWEAK USART2_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
USART2_IRQHandler
        B USART2_IRQHandler

        PUBWEAK USART3_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
USART3_IRQHandler
        B USART3_IRQHandler

        PUBWEAK UART4_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
UART4_IRQHandler
        B UART4_IRQHandler

        PUBWEAK UART5_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
UART5_IRQHandler
        B UART5_IRQHandler

        PUBWEAK LPUART1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
LPUART1_IRQHandler
        B LPUART1_IRQHandler

        PUBWEAK LPTIM1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
LPTIM1_IRQHandler
        B LPTIM1_IRQHandler

        PUBWEAK TIM8_BRK_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM8_BRK_IRQHandler
        B TIM8_BRK_IRQHandler

        PUBWEAK TIM8_UP_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM8_UP_IRQHandler
        B TIM8_UP_IRQHandler

        PUBWEAK TIM8_TRG_COM_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM8_TRG_COM_IRQHandler
        B TIM8_TRG_COM_IRQHandler

        PUBWEAK TIM8_CC_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM8_CC_IRQHandler
        B TIM8_CC_IRQHandler

        PUBWEAK ADC2_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
ADC2_IRQHandler
        B ADC2_IRQHandler

        PUBWEAK LPTIM2_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
LPTIM2_IRQHandler
        B LPTIM2_IRQHandler

        PUBWEAK TIM15_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM15_IRQHandler
        B TIM15_IRQHandler

        PUBWEAK TIM16_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM16_IRQHandler
        B TIM16_IRQHandler

        PUBWEAK TIM17_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM17_IRQHandler
        B TIM17_IRQHandler

        PUBWEAK USB_DRD_FS_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
USB_DRD_FS_IRQHandler
        B USB_DRD_FS_IRQHandler

        PUBWEAK CRS_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
CRS_IRQHandler
        B CRS_IRQHandler

        PUBWEAK UCPD1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
UCPD1_IRQHandler
        B UCPD1_IRQHandler

        PUBWEAK FMC_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
FMC_IRQHandler
        B FMC_IRQHandler

        PUBWEAK OCTOSPI1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
OCTOSPI1_IRQHandler
        B OCTOSPI1_IRQHandler

        PUBWEAK SDMMC1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
SDMMC1_IRQHandler
        B SDMMC1_IRQHandler

        PUBWEAK I2C3_EV_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
I2C3_EV_IRQHandler
        B I2C3_EV_IRQHandler

        PUBWEAK I2C3_ER_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
I2C3_ER_IRQHandler
        B I2C3_ER_IRQHandler

        PUBWEAK SPI4_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
SPI4_IRQHandler
        B SPI4_IRQHandler

        PUBWEAK SPI5_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
SPI5_IRQHandler
        B SPI5_IRQHandler

        PUBWEAK SPI6_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
SPI6_IRQHandler
        B SPI6_IRQHandler

        PUBWEAK USART6_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
USART6_IRQHandler
        B USART6_IRQHandler

        PUBWEAK USART10_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
USART10_IRQHandler
        B USART10_IRQHandler

        PUBWEAK USART11_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
USART11_IRQHandler
        B USART11_IRQHandler

        PUBWEAK SAI1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
SAI1_IRQHandler
        B SAI1_IRQHandler

        PUBWEAK SAI2_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
SAI2_IRQHandler
        B SAI2_IRQHandler

        PUBWEAK GPDMA2_Channel0_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GPDMA2_Channel0_IRQHandler
        B GPDMA2_Channel0_IRQHandler

        PUBWEAK GPDMA2_Channel1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GPDMA2_Channel1_IRQHandler
        B GPDMA2_Channel1_IRQHandler

        PUBWEAK GPDMA2_Channel2_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GPDMA2_Channel2_IRQHandler
        B GPDMA2_Channel2_IRQHandler

        PUBWEAK GPDMA2_Channel3_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GPDMA2_Channel3_IRQHandler
        B GPDMA2_Channel3_IRQHandler

        PUBWEAK GPDMA2_Channel4_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GPDMA2_Channel4_IRQHandler
        B GPDMA2_Channel4_IRQHandler

        PUBWEAK GPDMA2_Channel5_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GPDMA2_Channel5_IRQHandler
        B GPDMA2_Channel5_IRQHandler

        PUBWEAK GPDMA2_Channel6_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GPDMA2_Channel6_IRQHandler
        B GPDMA2_Channel6_IRQHandler

        PUBWEAK GPDMA2_Channel7_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
GPDMA2_Channel7_IRQHandler
        B GPDMA2_Channel7_IRQHandler

        PUBWEAK UART7_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
UART7_IRQHandler
        B UART7_IRQHandler

        PUBWEAK UART8_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
UART8_IRQHandler
        B UART8_IRQHandler

        PUBWEAK UART9_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
UART9_IRQHandler
        B UART9_IRQHandler

        PUBWEAK UART12_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
UART12_IRQHandler
        B UART12_IRQHandler

        PUBWEAK SDMMC2_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
SDMMC2_IRQHandler
        B SDMMC2_IRQHandler

        PUBWEAK FPU_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
FPU_IRQHandler
        B FPU_IRQHandler

        PUBWEAK ICACHE_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
ICACHE_IRQHandler
        B ICACHE_IRQHandler

        PUBWEAK DCACHE1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
DCACHE1_IRQHandler
        B DCACHE1_IRQHandler

        PUBWEAK ETH_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
ETH_IRQHandler
        B ETH_IRQHandler

        PUBWEAK ETH_WKUP_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
ETH_WKUP_IRQHandler
        B ETH_WKUP_IRQHandler

        PUBWEAK DCMI_PSSI_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
DCMI_PSSI_IRQHandler
        B DCMI_PSSI_IRQHandler

        PUBWEAK FDCAN2_IT0_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
FDCAN2_IT0_IRQHandler
        B FDCAN2_IT0_IRQHandler

        PUBWEAK FDCAN2_IT1_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
FDCAN2_IT1_IRQHandler
        B FDCAN2_IT1_IRQHandler

        PUBWEAK CORDIC_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
CORDIC_IRQHandler
        B CORDIC_IRQHandler

        PUBWEAK FMAC_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
FMAC_IRQHandler
        B FMAC_IRQHandler

        PUBWEAK DTS_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
DTS_IRQHandler
        B DTS_IRQHandler

        PUBWEAK RNG_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
RNG_IRQHandler
        B RNG_IRQHandler

        PUBWEAK HASH_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
HASH_IRQHandler
        B HASH_IRQHandler

        PUBWEAK CEC_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
CEC_IRQHandler
        B CEC_IRQHandler

        PUBWEAK TIM12_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM12_IRQHandler
        B TIM12_IRQHandler

        PUBWEAK TIM13_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM13_IRQHandler
        B TIM13_IRQHandler

        PUBWEAK TIM14_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
TIM14_IRQHandler
        B TIM14_IRQHandler

        PUBWEAK I3C1_EV_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
I3C1_EV_IRQHandler
        B I3C1_EV_IRQHandler

        PUBWEAK I3C1_ER_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
I3C1_ER_IRQHandler
        B I3C1_ER_IRQHandler

        PUBWEAK I2C4_EV_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
I2C4_EV_IRQHandler
        B I2C4_EV_IRQHandler

        PUBWEAK I2C4_ER_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
I2C4_ER_IRQHandler
        B I2C4_ER_IRQHandler

        PUBWEAK LPTIM3_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
LPTIM3_IRQHandler
        B LPTIM3_IRQHandler

        PUBWEAK LPTIM4_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
LPTIM4_IRQHandler
        B LPTIM4_IRQHandler

        PUBWEAK LPTIM5_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
LPTIM5_IRQHandler
        B LPTIM5_IRQHandler

        PUBWEAK LPTIM6_IRQHandler
        SECTION .text:CODE:NOROOT:REORDER(1)
LPTIM6_IRQHandler
        B LPTIM6_IRQHandler

        END
