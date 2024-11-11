package com.powerteam.service.masterData;

import com.powerteam.mapper.masterData.DistrictMapper;
import com.powerteam.model.masterData.District;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DistrictService {

    @Autowired
    private DistrictMapper districtMapper;

    /**
     * 获取省份
     *
     * @return
     */
    public List<District> findAllProvince() {
        return districtMapper.findAllProvince();
    }

    /**
     * 获取某省份下的城市
     *
     * @param provinceId 省份Id
     * @return
     */
    public List<District> findCity(int provinceId) {
        return districtMapper.findCity(provinceId);
    }

    /**
     * 获取某城市下的区县
     *
     * @param cityId 城市Id
     * @return
     */
    public List<District> findCounty(int cityId) {
        return districtMapper.findCounty(cityId);
    }
}
