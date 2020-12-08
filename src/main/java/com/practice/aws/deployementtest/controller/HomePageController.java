package com.practice.aws.deployementtest.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;

@RestController
@RequiredArgsConstructor
@Slf4j
public class HomePageController {

    @GetMapping("/")
    public String home() {
        log.info("Entered home page url....");
        return "Welcome to AWS Docker Deployed Home Page......";
    }

    @GetMapping("/users")
    public List<String> getUsers() {
        log.info("Entered getUsers url....");
        return Arrays.asList("User1", "User2", "User3", "User4");
    }

    @GetMapping("/users/{userId}")
    public String getUser(@PathVariable("userId") String userId) {
        log.info("Entered getUser url....");
        return userId;
    }
}
