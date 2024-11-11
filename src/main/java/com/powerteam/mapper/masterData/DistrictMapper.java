package com.powerteam.mapper.masterData;

import com.powerteam.model.masterData.District;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DistrictMapper {

    List<District> findAllProvince();

    List<District> findCity(int provinceId);

    List<District> findCounty(int cityId);
}
