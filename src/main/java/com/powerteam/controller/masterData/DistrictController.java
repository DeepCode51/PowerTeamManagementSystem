package com.powerteam.controller.masterData;

import com.powerteam.model.masterData.District;
import com.powerteam.service.masterData.DistrictService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/district")
public class DistrictController {

    @Autowired
    private DistrictService districtService;

    @RequestMapping(value = "/findAllProvince", method = RequestMethod.POST)
    @ResponseBody
    public List<District> findAllProvince() {
        return districtService.findAllProvince();
    }

    @RequestMapping(value = "/findCity", method = RequestMethod.POST)
    @ResponseBody
    public List<District> findCity(@RequestBody int provinceId) {
        return districtService.findCity(provinceId);
    }

    @RequestMapping(value = "/findCounty", method = RequestMethod.POST)
    @ResponseBody
    public List<District> findCounty(@RequestBody int cityId) {
        return districtService.findCounty(cityId);
    }
}
