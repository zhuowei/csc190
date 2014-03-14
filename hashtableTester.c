#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hashtable.h"

void printHashTable(HashTablePTR table) {
	char** keys;
	unsigned int keyCount;
	GetKeys(table, (char* (*)[]) &keys, &keyCount);
	for (unsigned int i = 0; i < keyCount; i++) {
		char* dat;
		char* key = keys[i];
		FindEntry(table, key, (void**) &dat);
		printf("%s:%s\n", key, dat);
	}
	free(keys);
}

void freeHashTableContents(HashTablePTR table) {
	char** keys;
	unsigned int keyCount;
	GetKeys(table, (char* (*)[]) &keys, &keyCount);
	for (unsigned int i = 0; i < keyCount; i++) {
		char* dat;
		char* key = keys[i];
		FindEntry(table, key, (void**) &dat);
		free(dat);
	}
	free(keys);
}

int main() {
	HashTablePTR table = NULL;
	for(;;) {
		char cmd[80];
		printf("Command: ");
		int retval = scanf("%79s", cmd);
		if (retval <= 0) break;
		if (strcmp(cmd, "create") == 0) {
			printf("Size: ");
			int size;
			scanf("%d", &size);
			/* note: this is a signed int because unsigned int
			 * conversion in scanf is drunk and return 0xffffffff
			 * for -1.
			 */
			if (size < 0) {
				printf("Size cannot be negative, clamping to 0.\n");
				size = 0;
			}
			if (table != NULL) DestroyHashTable(&table);
			CreateHashTable(&table, (unsigned int) size);
			
			if (table == NULL) {
				printf("create returned NULL\n");
			} else {
				printf("create returned non-NULL\n");
				if (table->sentinel != (int) 0xDEADBEEF) {
					printf("FAIL: sentinel is WRONG, is %X", table->sentinel);
				}
			}
		} else if (strcmp(cmd, "destroy") == 0) {
			freeHashTableContents(table);
			DestroyHashTable(&table);
			if (table != NULL) {
				printf("FAIL: destroy did not set NULL");
			}
		} else if (strcmp(cmd, "print") == 0) {
			printHashTable(table);
		} else if (strcmp(cmd, "set") == 0) {
			printf("Key: ");
			char key[81];
			scanf(" %80s", key);
			char* value = malloc(81 * sizeof(char));
			scanf(" %80s", value);
			char* existingData = NULL;
			int success = InsertEntry(table, key, value, (void**) &existingData);
			switch(success){
				case 0:
					printf("Inserted into blank space\n");
					break;
				case -1:
					printf("Inserted after resolving hash collision\n");
					break;
				case -2:
					printf("Inserted after removing existing data: %s\n", existingData);
					free(existingData);
					break;
			}
		} /*else if (strcmp(cmd, "read") == 0) {
			printf("Position: ");
			unsigned int position;
			scanf("%u", &position);
			int value;
			int success = readPosition(table, &value, position);
			if (success == 0) {
				printf("%d\n", value);
			} else {
				printf("readPosition returned failure\n");
			}
		} else if (strcmp(cmd, "insert") == 0) {
			printf("Value and position: ");
			int value;
			unsigned int position;
			scanf("%d %u", &value, &position);
			int success = insertPosition(table, value, position);
			printf(success == 0? "insertPosition returned success\n":
				"insertPosition returned failure\n");
		} else if (strcmp(cmd, "delete") == 0) {
			printf("Position: ");
			unsigned int position;
			scanf("%u", &position);
			int success = deletePosition(table, position);
			printf(success == 0? "deletePosition returned success\n":
				"deletePosition returned failure\n");
		} */ else if (strcmp(cmd, "quit") == 0) {
			break;
		} else {
			printf("Invalid command\n");
		}
	}
	if (table != NULL) {
		freeHashTableContents(table);
		DestroyHashTable(&table);
	}
	return 0;
}
