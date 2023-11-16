cmake_minimum_required(VERSION 3.24)
project(cuda-learn-practice C)

set(CMAKE_C_STANDARD 11)

add_executable(cuda-learn-practice main.c code/vector_addition.cu)
