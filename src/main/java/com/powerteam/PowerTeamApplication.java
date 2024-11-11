package com.powerteam;

import com.powerteam.config.PowerTeamConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

@SpringBootApplication
public class PowerTeamApplication implements ApplicationListener<ContextRefreshedEvent> {

    public static void main(String[] args) {
        SpringApplication.run(PowerTeamApplication.class, args);
    }

    @Autowired
    private PowerTeamConfig powerTeamConfig;

    @Override
    public void onApplicationEvent(final ContextRefreshedEvent event) {
        powerTeamConfig.setWebRoot(event.getApplicationContext().getApplicationName() + "/");
        powerTeamConfig.setAbsoluteWebRoot(this.getClass().getResource("/").getPath().replaceFirst("/", ""));
    }
}
