package com.example.devopspractices;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
class SomeController {

    @GetMapping("/")
    public String getSomeWord() {
        return "Hello Devops! =)";
    }
}
