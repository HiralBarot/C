#include <stdio.h>
#include <stdbool.h>
#include "distribution.h"
#include "datablock.h"

#define RUN_TEST(RESULT, DESCRIPTION) \
do { \
    if (RESULT) { \
        printf("Test Passed: %s\n\n", DESCRIPTION); \
    } else { \
        printf("Test Failed: %s\n\n", DESCRIPTION); \
    } \
} while(0)

//Test basic write/read & data conversion
bool basic_write_read(void)
{
    status_e status;
    uint64_t command;
    uint64_t expected;

    //write 0xA1B2C3D4 to index 5
    command = 0x286cb0f502a;
    if ((status = process_command(&command)) != SUCCESS)
    {
        printf("ERROR: Basic write read: write to index 5 failed with %d\n", (int)status);
        return false;
    }
    //read the data back from index 5
    command = 0x29;
    if ((status = process_command(&command)) != SUCCESS)
    {
        printf("ERROR: Basic write read: reading back data from index 5 failed with %d\n", (int)status);
        return false;
    }
    expected = 0x286cb0f5029;
    if (command != expected)
    {
        printf("ERROR: Basic write read: Retrieved data does not match expected data\n");
        printf("ERROR: Basic write read: Actual: %lx, Expected: %lx\n", command, expected);
        return false;
    }

    return true;
}

//Repeatedly write to a single index until full
//Minimum writes achieved should be BLOCK_MAX_WRITES, maximum writes possible is (BLOCK_MAX_WRITES * NUM_DATA_BLOCKS)
bool repeated_write(void)
{
    int i;
    int counter;
    unsigned char flag;
    status_e status;
    uint64_t data = 0xA1B1C1D1;
    uint64_t expected;
    uint64_t command;

    counter = 0;
    flag = 1;
    for (i = 0; i < ((BLOCK_MAX_WRITES * NUM_DATA_BLOCKS) + 10) && flag; i++)
    {
        command = 0xA + (data << 10);
        status = process_command(&command);
        if (status == BLOCK_FULL)
        {
            //system says it's full, stop the writes
            flag = 0;
        }
        else if (status != SUCCESS)
        {
            //stop the writes
            printf("ERROR: Repeated write: Write of data failed with error %d\n", (int)status);
            flag = 0;
            return false;
        }
        else
        {
            data++;
            counter++;
        }
    }

    //check the stored data to make sure it's intact
    command = 0x9;
    expected = (0x9 + ((data - 1) << 10));
    if (process_command(&command) != SUCCESS)
    {
        printf("ERROR: Repeated write: Unable to read back data\n");
        return false;
    }
    else
    {
        if (command != expected)
        {
            printf("ERROR: Repeated write: Retrieved data does not match expected data\n");
            printf("ERROR: Repeated write: Actual: %lx, Expected: %lx\n", command, expected);
            return false;
        }
    }

    printf("INFO: Repeated write: Writes achieved: %d\n", counter);

    //test to make sure at least the minimum number of writes is achieved
    if (counter < BLOCK_MAX_WRITES)
    {
        printf("ERROR: Repeated write: Minimum write count not achieved\n");
        return false;
    }

    //test to make sure the number of writes did not exceed the max before the system declared it was full
    if (counter > (BLOCK_MAX_WRITES * NUM_DATA_BLOCKS))
    {
        printf("ERROR: Repeated write: Actual write count exceeds theoretical write count\n");
        return false;
    }

    return true;
}


int main(int argc, char *argv[])
{
    initialize();

    printf("Testing a single write/read and bit conversion\n");
    RUN_TEST(basic_write_read(), "Basic write and read");
    reset();    //reset the system so we can run another test

    printf("Testing repeated write to same index\n");
    RUN_TEST(repeated_write(), "Repeated write");
    reset();    //reset the system so we can run another test

    return 0;
}
