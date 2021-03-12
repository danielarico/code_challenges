/* Script to solve challenge 172 from Codeabbey - Cloud Altitude Measurement */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef M_PI
  #define M_PI 3.14159265358979323846
#endif

#define TESTCASE_NUM_LEN 5
#define TESTCASE_LEN 30
#define TESTCASE_DATA 3

/*
 * Reads testcases number
 *
 *  returns: number of testcases to be read as integer
 */
static int get_testcases_number(void) /*@*/ {
  int testcases_number;
  char * char_ptr;
  size_t size_ptr = (size_t) TESTCASE_NUM_LEN;
  /*@null@*/ char *tc_number_str = calloc(size_ptr, sizeof(*char_ptr));

  if(tc_number_str == NULL) {
    return(0);
  }

  tc_number_str = fgets(tc_number_str, TESTCASE_NUM_LEN, stdin);
  testcases_number = atoi(tc_number_str);
  free(tc_number_str);
  return(testcases_number);
}

/*
 * Reads testcases
 *
 *  testcases_number: number of given testcases
 *  i: iteration variable
 *  testcases_str: pointer to char array to store testcases
 */
 static void get_testcases(int testcases_number, int i,
                           /*@null@*/ char *testcases_str)
                           /*@modifies *testcases_str@*/{
  /*@null@*/ char *temp_ptr;

  if (testcases_str == NULL) {
    return;
  }

  temp_ptr = &testcases_str[i * TESTCASE_LEN];

  if (temp_ptr == NULL) {
    return;
  }

  if (i == testcases_number) {
    return;
  }

  if(i < testcases_number) {
    temp_ptr = fgets(temp_ptr, TESTCASE_LEN, stdin);
    testcases_str[i * TESTCASE_LEN] = *temp_ptr;
    get_testcases(testcases_number, i + 1, testcases_str);
  }
}

/*
 * Splits a string by whitespaces and convert each part into float
 *
 *  current_testcase: string to be splitted
 *  split_str: pointer to store splitted string
 *  arr_floats: pointer to float array to store resulting floats
 *  i: iteration variable
 *  ref: reference pointer for strtok_r function
 */
static void split_as_float(char *current_testcase, /*@null@*/ char *split_str,
                           float *arr_floats, int i, /*@null@*/ char **ref)
                           /*@modifies *arr_floats@*/{
  if (split_str == NULL || ref == NULL) {
    return;
  }

  if (i == 0) {
    split_str = strtok_r(current_testcase, " ", ref);
    *arr_floats = (float) atof(split_str);
    split_as_float(current_testcase, split_str, arr_floats, i + 1, ref);
  }

  if(i != 0 && i < TESTCASE_DATA) {
    split_str = strtok_r(NULL, " ", ref);
    arr_floats[i] = (float) atof(split_str);
    split_as_float(current_testcase, split_str, arr_floats, i + 1, ref);
  }

  return;
}

/*
 * Converts input from string to floats for each testcase
 *
 *  testcases_str: pointer to char array that contains strings
 *  testcases_float: pointer to float array to store floats
 *  i: iteration variable for testcases_str
 *  j: iteration variable for testcases_float
 *  testcases_num: number of testcases
 */
static void transform_input(/*@null@*/ char *testcases_str,
                            /*@null@*/ float *testcases_float, int i, int j,
                            int testcases_num) /*@modifies *testcases_float@*/{
  size_t size_splitted = (size_t) 10;
  size_t ref_size = (size_t) 8;
  char * current_testcase;
  char *char_ptr;
  /*@null@*/ char *split_str;
  /*@null@*/ char **ref;

  if (testcases_str == NULL || testcases_float == NULL) {
    return;
  }

  current_testcase = &testcases_str[i * TESTCASE_LEN];
  split_str = calloc(size_splitted, sizeof(*char_ptr));
  ref = calloc(ref_size, sizeof(*char_ptr));

  if(i == testcases_num) {
    free(split_str);
    free(ref);
    split_str = NULL;
    ref = NULL;
    return;
  }

  /* testcases_str jumps 1 and testcases_float jumps 3 */
  split_as_float(current_testcase, split_str, &testcases_float[j], 0, ref);

  free(split_str);
  free(ref);
  split_str = NULL;
  ref = NULL;
  transform_input(testcases_str, testcases_float, i + 1, j + TESTCASE_DATA,
                  testcases_num);
}

/*
 * Computes altitudes for each testcase
 *
 *  testcases_float: pointer to float array that contains testcases data
 *  i: iteration variable
 *  answer: pointer to int array to store the altitudes
 *  testcases_num: number of testcases
 */
static void find_altitudes(/*@null@*/ float *testcases_float, int i, int j,
                           /*@null@*/ int *answer, int testcases_num)
                           /*@modifies *answer@*/ {
  float d1;
  double angle_a, angle_b, altitude;

  if (testcases_float == NULL || answer == NULL) {
    return;
  }

  if(i == testcases_num) {
    return;
  }

  if(i < testcases_num) {
    d1 = testcases_float[j + 0];
    angle_a = testcases_float[j + 1] * M_PI / 180;
    angle_b = testcases_float[j + 2] * M_PI / 180;

    altitude = (double) (tan(angle_a) * d1) /
                        (1.0 - tan(angle_a) / tan(angle_b));
    answer[i] = (int) round(altitude);
  }

  find_altitudes(testcases_float, i + 1, j + TESTCASE_DATA, answer,
                 testcases_num);
}

/*
 * Prints computed altitudes for each testcase
 *
 *  answer: pointer to int array that contains computed altitudes
 *  i: iteration variable
 *  testcases_num: number of given testcases
 */
static void print_answer(/*@null@*/ int *answer, int i, int testcases_num)
                         /*@*/ {
  if (answer == NULL) {
    return;
  }

  if(i == testcases_num) {
    return;
  }

  printf("%d ", answer[i]);
  print_answer(answer, i + 1, testcases_num);
}

/*
 * Computes and prints cloud altitudes for a set of testcases
 */
int main(void) {
  int testcases_num = get_testcases_number();

  size_t size_tc_str = (size_t) testcases_num * TESTCASE_LEN;
  size_t size_tc_float = (size_t) testcases_num * TESTCASE_DATA;
  size_t size_answer = (size_t) testcases_num;

  char *char_ptr;
  int *int_ptr;
  float *float_ptr;

  /*@null@*/ char *testcases_str = (char*) calloc(size_tc_str,
                                   sizeof(*char_ptr));
  /*@null@*/ float *testcases_float = (float*) calloc(size_tc_float,
                                      sizeof(*float_ptr));
  /*@null@*/ int *answer = (int*) calloc(size_answer, sizeof(*int_ptr));

  get_testcases(testcases_num, 0, testcases_str);
  transform_input(testcases_str, testcases_float, 0, 0, testcases_num);
  find_altitudes(testcases_float, 0, 0, answer, testcases_num);
  print_answer(answer, 0, testcases_num);

  free(testcases_str);
  free(testcases_float);
  free(answer);

  testcases_str = NULL;
  testcases_float = NULL;
  answer = NULL;

  return(0);
}

/*
$ cat DATA.lst | ./danielaricoa
1731 1044 1069 1743 1866 1971 1185 1925 1352 537 1722 572 1160 1303 1365 837
1684 523
*/
