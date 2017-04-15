#include <stdbool.h>
#include <stdio.h>
#include "distribution.h"
#include "datablock.h"

/**********************************************************
 **********************************************************
       Implement your distribution system in this file.
      You may add additional private functions as needed.
 **********************************************************
 **********************************************************
 */

/**
 * Debug/testing function to "reset" the distribution system back to default
 * --- Implement This Function As Needed ---
 */
void reset(void)
{
    int i;

    //reset the data blocks
    //leave this here. Implement additional reset code below.
    reset_data_blocks();

    //do any other reset needed here
}

/**
 * Process the requested command
 * --- Implement This Function ---
 * @param command Pointer to the bit-packed command data containing the command type (bit 0-2), user index (bit 3-9), and data (bit 10-41)
 * @return Status of the comamnd request.
 * return SUCCESS on successful write to or read from a data_block_t
 * return BLOCK_FULL for a write command if all blocks writes have been "used up"
 * return DATA_INVALID for failed read commands, or any other failures
 * On read SUCCESS, data should be packed into the correct location in the command pointer (bits 10-41).
 */
status_e process_command(uint64_t *command)
{
	
	uint64_t input = *command;
	uint8_t type = input & 0x7;
	uint8_t index = (index & 0x3F8) >> 3;
	uint32_t data = (index & 0x3FFFFFFFC00) >> 10;
	
	
	switch(type)
	{
		case CMD_READ:
			
			if(read_data_block(index, &data) == SUCCESS)
			{
				uint64_t temp = data;
				temp = temp << 10;
				*command = *command | temp;
				
				return SUCCESS;
			}
			else
			{
				return DATA_INVALID;
			}
			break;
			
		case CMD_WRITE:
			
			if(write_data_block(index, data) == BLOCK_FULL)
			{
				return BLOCK_FULL;
			}
			else if(write_data_block(index, data) == SUCCESS)
			{
				return SUCCESS;
			}
			else
			{
				return DATA_INVALID;
			}
			break;
			
		
	}

}

/**
 * Function to do any initialization required
 * --- Implement This Function ---
 */
void initialize(void)
{
    //leave this here. Implement additional initialization code below.
    reset();

    //do any other initialization needed here
}
