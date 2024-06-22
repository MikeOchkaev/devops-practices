package com.example.devopspractices.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
class SomeController {

    @GetMapping("/")
    public String getSomeWord() {
        return UUID.randomUUID().toString();
    }
}
