package com.yanftch.book.test;

import javax.inject.Inject;

/**
 * User : yanftch
 * Date : 2019-10-15
 * Time : 17:15
 * Desc :
 */

public class Student {
    @Inject
    public Student() {

    }
    private int age;

    public int getAge() {
        return age;
    }

    public Student setAge(int age) {
        this.age = age;
        return this;
    }

    public String getName() {
        return name;
    }

    public Student setName(String name) {
        this.name = name;
        return this;
    }

    private String name;

    @Override
    public String toString() {
        return "Student{" +
                "age=" + age +
                ", name='" + name + '\'' +
                '}';
    }
}