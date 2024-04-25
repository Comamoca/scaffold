cmake_minimum_required(VERSION 3.28)
project(c-cli C)

add_executable(${PROJECT_NAME} ./src/main.c)

target_include_directories(${PROJECT_NAME} PRIVATE ./src/lib)
