package com.powerteam.mapper.masterData;


import com.powerteam.model.masterData.OrgUnit;
import com.powerteam.model.masterData.OrgUnitUser;
import com.powerteam.model.sys.User;
import com.powerteam.vo.masterData.QueryOrgUnitUserVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OrgUnitMapper {

    List<OrgUnit> findAllOrgUnit();

    int findMaxOrgIndex();

    int insert(OrgUnit orgUnit);

    Boolean existRootOrgUnit();

    int update(OrgUnit orgUnit);

    int deleteWithChildren(Integer orgUnitId);

    OrgUnit findById(Integer orgUnitId);

    OrgUnit findPreviousUnit(Integer orgUnitId);

    OrgUnit findNextUnit(Integer orgUnitId);

    List<User> findUserNotInOrgUnit(QueryOrgUnitUserVo vo);

    List<OrgUnitUser> findUserInOrgUnit(QueryOrgUnitUserVo vo);

    int insertOrgUnitUser(OrgUnitUser orgUnitUser);

    int deleteOrgUnitUser(OrgUnitUser orgUnitUser);

    int setUnitHead(OrgUnitUser orgUnitUser);

    int removeUnitHead(OrgUnitUser orgUnitUser);

    List<Integer> findSubordinate(Integer userId);
}
