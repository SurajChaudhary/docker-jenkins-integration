package com.practice.aws.deployementtest;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@EnableJpaRepositories(basePackages = "com.practice.aws.deployementtest.controller")
@Configuration
public class Config {
}
