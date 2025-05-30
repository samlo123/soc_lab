/*
 * SPDX-FileCopyrightText: 2020 Efabless Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * SPDX-License-Identifier: Apache-2.0
 */

// This include is relative to $CARAVEL_PATH (see Makefile)
#include <defs.h>
#include <stub.c>

#include <user_uart.h>
#ifdef USER_PROJ_IRQ0_EN
#include <irq_vex.h>
#endif

#define N 11
#define data_length 64

#define reg_fir_control (*(volatile uint32_t *)0x36000000)
#define reg_fir_coef (*(volatile uint32_t *)0x36000040)

#define reg_fir_x (*(volatile uint32_t *)0x36000080)
#define reg_fir_y (*(volatile uint32_t *)0x36000084)

#define reg_tap (*(volatile uint32_t *)0x35000C00)
#define reg_data (*(volatile uint32_t *)0x35000C40)

extern void uart_write();
extern void uart_write_char();
extern void uart_write_string();
extern void uart_reset_write_fifo();
extern int uart_isr();
extern int uart_read();

//extern int* fir();
extern void initfir();
extern int* matmul();
extern int* qsort();

// --------------------------------------------------------

/*
	MPRJ Logic Analyzer Test:
		- Observes counter value through LA probes [31:0] 
		- Sets counter initial value through LA probes [63:32]
		- Flags when counter value exceeds 500 through the management SoC gpio
		- Outputs message to the UART when the test concludes successfuly
*/

void main()
{
#ifdef USER_PROJ_IRQ0_EN
    int mask;
#endif

	int j;

	/* Set up the housekeeping SPI to be connected internally so	*/
	/* that external pin changes don't affect it.			*/

	// reg_spi_enable = 1;
	// reg_spimaster_cs = 0x00000;

	// reg_spimaster_control = 0x0801;

	// reg_spimaster_control = 0xa002;	// Enable, prescaler = 2,
                                        // connect to housekeeping SPI

	// Connect the housekeeping SPI to the SPI master
	// so that the CSB line is not left floating.  This allows
	// all of the GPIO pins to be used for user functions.

	// The upper GPIO pins are configured to be output
	// and accessble to the management SoC.
	// Used to flad the start/end of a test 
	// The lower GPIO pins are configured to be output
	// and accessible to the user project.  They show
	// the project count value, although this test is
	// designed to read the project count through the
	// logic analyzer probes.
	// I/O 6 is configured for the UART Tx line
	
	//reg_spi_enable = 1;
    	reg_wb_enable = 1;
	
        reg_mprj_io_31 = GPIO_MODE_MGMT_STD_OUTPUT;
        reg_mprj_io_30 = GPIO_MODE_MGMT_STD_OUTPUT;
        reg_mprj_io_29 = GPIO_MODE_MGMT_STD_OUTPUT;
        reg_mprj_io_28 = GPIO_MODE_MGMT_STD_OUTPUT;
        reg_mprj_io_27 = GPIO_MODE_MGMT_STD_OUTPUT;
        reg_mprj_io_26 = GPIO_MODE_MGMT_STD_OUTPUT;
        reg_mprj_io_25 = GPIO_MODE_MGMT_STD_OUTPUT;
        reg_mprj_io_24 = GPIO_MODE_MGMT_STD_OUTPUT;
        reg_mprj_io_23 = GPIO_MODE_MGMT_STD_OUTPUT;
        reg_mprj_io_22 = GPIO_MODE_MGMT_STD_OUTPUT;
        reg_mprj_io_21 = GPIO_MODE_MGMT_STD_OUTPUT;
        reg_mprj_io_20 = GPIO_MODE_MGMT_STD_OUTPUT;
        reg_mprj_io_19 = GPIO_MODE_MGMT_STD_OUTPUT;
        reg_mprj_io_18 = GPIO_MODE_MGMT_STD_OUTPUT;
        reg_mprj_io_17 = GPIO_MODE_MGMT_STD_OUTPUT;
        reg_mprj_io_16 = GPIO_MODE_MGMT_STD_OUTPUT;
    	
    	reg_mprj_io_15 = GPIO_MODE_MGMT_STD_OUTPUT;
    	reg_mprj_io_14 = GPIO_MODE_MGMT_STD_OUTPUT;
    	reg_mprj_io_13 = GPIO_MODE_MGMT_STD_OUTPUT;
    	reg_mprj_io_12 = GPIO_MODE_MGMT_STD_OUTPUT;
    	reg_mprj_io_11 = GPIO_MODE_MGMT_STD_OUTPUT;
    	reg_mprj_io_10 = GPIO_MODE_MGMT_STD_OUTPUT;
    	reg_mprj_io_9  = GPIO_MODE_MGMT_STD_OUTPUT;
    	reg_mprj_io_8  = GPIO_MODE_MGMT_STD_OUTPUT;
    	reg_mprj_io_7  = GPIO_MODE_MGMT_STD_OUTPUT;
    	reg_mprj_io_4  = GPIO_MODE_MGMT_STD_OUTPUT;
    	reg_mprj_io_3  = GPIO_MODE_MGMT_STD_OUTPUT;
    	reg_mprj_io_2  = GPIO_MODE_MGMT_STD_OUTPUT;
    	reg_mprj_io_1  = GPIO_MODE_MGMT_STD_OUTPUT;
    	reg_mprj_io_0  = GPIO_MODE_MGMT_STD_OUTPUT;

    	reg_mprj_io_6  = GPIO_MODE_USER_STD_OUTPUT;
    	reg_mprj_io_5  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    	//reg_mprj_io_4  = GPIO_MODE_USER_STD_OUTPUT;


	// Set UART clock to 64 kbaud (enable before I/O configuration)
	// reg_uart_clkdiv = 625;
	reg_uart_enable = 1;
	
	// Now, apply the configuration
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1);

        // Configure LA probes [31:0], [127:64] as inputs to the cpu 
	// Configure LA probes [63:32] as outputs from the cpu
	reg_la0_oenb = reg_la0_iena = 0x00000000;    // [31:0]
	reg_la1_oenb = reg_la1_iena = 0xFFFFFFFF;    // [63:32]
	reg_la2_oenb = reg_la2_iena = 0x00000000;    // [95:64]
	reg_la3_oenb = reg_la3_iena = 0x00000000;    // [127:96]

	// Flag start of the test 
	reg_mprj_datal = 0xAB400000;

	// Set Counter value to zero through LA probes [63:32]
	reg_la1_data = 0x00000000;

	// Configure LA probes from [63:32] as inputs to disable counter write
	reg_la1_oenb = reg_la1_iena = 0x00000000;    
	
#ifdef USER_PROJ_IRQ0_EN	
	// unmask USER_IRQ_0_INTERRUPT
	mask = irq_getmask();
	mask |= 1 << USER_IRQ_0_INTERRUPT; // USER_IRQ_0_INTERRUPT = 2
	irq_setmask(mask);
	// enable user_irq_0_ev_enable
	user_irq_0_ev_enable_write(1);	
#endif
	
	// //mm	
	int* tmp1 = matmul();
	reg_mprj_datal = *tmp1 << 16;
	reg_mprj_datal = *(tmp1+1) << 16;
	reg_mprj_datal = *(tmp1+2) << 16;
	reg_mprj_datal = *(tmp1+3) << 16;
	
	reg_mprj_datal = *(tmp1+9) << 16;
	
	reg_mprj_datal = 0xAB510000;
	
	//qsort	
	int* tmp2 = qsort();
	reg_mprj_datal = *tmp2 << 16;
	reg_mprj_datal = *(tmp2+1) << 16;
	reg_mprj_datal = *(tmp2+2) << 16;
	reg_mprj_datal = *(tmp2+3) << 16;
	reg_mprj_datal = *(tmp2+4) << 16;
	reg_mprj_datal = *(tmp2+5) << 16;
	reg_mprj_datal = *(tmp2+6) << 16;
	reg_mprj_datal = *(tmp2+7) << 16;
	reg_mprj_datal = *(tmp2+8) << 16;
	reg_mprj_datal = *(tmp2+9) << 16;
	
	reg_mprj_datal = 0xAB520000;
	
	// fir
	// int* tmp3 = fir();
	// reg_mprj_datal = *tmp3 << 16;
	// reg_mprj_datal = *(tmp3+1) << 16;
	// reg_mprj_datal = *(tmp3+2) << 16;
	// reg_mprj_datal = *(tmp3+3) << 16;
	// reg_mprj_datal = *(tmp3+4) << 16;
	// reg_mprj_datal = *(tmp3+5) << 16;
	// reg_mprj_datal = *(tmp3+6) << 16;
	// reg_mprj_datal = *(tmp3+7) << 16;
	// reg_mprj_datal = *(tmp3+8) << 16;
	// reg_mprj_datal = *(tmp3+9) << 16;
	// reg_mprj_datal = *(tmp3+10) << 16;	

	
	initfir();

	uint32_t tap1;
	for (int i = 0; i < N; i++)
	{	
		tap1 = (*(volatile uint32_t *)(0x35000C00+(0X0004*i)));

		(*(volatile uint32_t *)(0x36000040+(0X0004*i))) = tap1;
	}
	
	reg_fir_control=0x01;

	uint32_t x;
	for (int i = 0; i < data_length; i++)
	{	
		x = (*(volatile uint32_t *)(0x35000C40+(0X0004*i)));

		reg_fir_x = x;	
	}	
	

	uint32_t y;
	y = reg_fir_y;	
	if (y == 0x2A2D) {
		reg_mprj_datal = (y<<24) | 0x00A60000; //0x2DA60000
	}
	
	
	reg_mprj_datal = 0xAB530000;	


}

