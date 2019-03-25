package com.happy.ui;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@PropertySources({ @PropertySource("classpath:config.properties") })
@ComponentScan(basePackages="/")
@EnableWebMvc
public class MvcConfiguration implements WebMvcConfigurer {	
	
}
