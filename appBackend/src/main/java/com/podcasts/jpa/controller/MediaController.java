package com.podcasts.jpa.controller;

import com.podcasts.jpa.service.MediaService;
import com.podcasts.jpa.util.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@RestController

@RequestMapping("/media")
public class MediaController {
    @Autowired
    MediaService mediaService;

    @GetMapping("/getMediaByArray")
    public void getMediaByArray(HttpServletResponse resp) throws IOException {
        List<String> lists = new ArrayList<>();
        lists.add("3");
        lists.add("4");
        Message message;
        message = mediaService.getMediaByArray(lists);
        message.returnJson(resp);
    }
}
