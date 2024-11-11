package com.powerteam.service.masterData;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.powerteam.mapper.masterData.OrgUnitMapper;
import com.powerteam.model.masterData.OrgUnit;
import com.powerteam.model.masterData.OrgUnitUser;
import com.powerteam.model.sys.User;
import com.powerteam.vo.Result;
import com.powerteam.vo.masterData.QueryOrgUnitUserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
public class OrgUnitService {

    @Autowired
    private OrgUnitMapper orgUnitMapper;

    public List<OrgUnit> findAllOrgUnit() {
        return orgUnitMapper.findAllOrgUnit();
    }

    @Transactional
    public Result insert(OrgUnit orgUnit) {
        Result result = new Result();

        if (orgUnit.getPid() == null && orgUnitMapper.existRootOrgUnit()) {
            result.setMessage("只能有一个根节点");
            return result;
        }
        orgUnit.setOrgIndex(orgUnitMapper.findMaxOrgIndex() + 1);
        result.setSuccess(orgUnitMapper.insert(orgUnit) > 0);
        return result;
    }

    @Transactional
    public Result update(OrgUnit orgUnit) {
        Result result = new Result();

        if (orgUnit.getPid() == null && orgUnitMapper.existRootOrgUnit()) {
            result.setMessage("只能有一个根节点");
            return result;
        }
        result.setSuccess(orgUnitMapper.update(orgUnit) > 0);
        return result;
    }

    @Transactional
    public Result delete(Integer orgUnitId) {
        return new Result(orgUnitMapper.deleteWithChildren(orgUnitId) > 0);
    }

    public OrgUnit findById(Integer orgUnitId) {
        return orgUnitMapper.findById(orgUnitId);
    }

    @Transactional
    public Result up(Integer orgUnitId) {
        OrgUnit previous = orgUnitMapper.findPreviousUnit(orgUnitId);
        if (previous != null) {
            OrgUnit unit = this.findById(orgUnitId);
            int tempIndex = 0;
            tempIndex = unit.getOrgIndex();
            unit.setOrgIndex(previous.getOrgIndex());
            previous.setOrgIndex(tempIndex);

            this.update(unit);
            this.update(previous);
        }
        return new Result(true);
    }

    @Transactional
    public Result down(Integer orgUnitId) {
        OrgUnit next = orgUnitMapper.findNextUnit(orgUnitId);
        if (next != null) {
            OrgUnit unit = this.findById(orgUnitId);
            int tempIndex = 0;
            tempIndex = unit.getOrgIndex();
            unit.setOrgIndex(next.getOrgIndex());
            next.setOrgIndex(tempIndex);

            this.update(unit);
            this.update(next);
        }
        return new Result(true);
    }

    public PageInfo<User> findUserNotInOrgUnit(QueryOrgUnitUserVo vo) {
        if (!StringUtils.isEmpty(vo.getWord())) {
            vo.setWord("%" + vo.getWord() + "%");
        }

        if (!vo.isDisablePaging()) {
            PageHelper.startPage(vo.getPageNum(), vo.getPageSize());
        }
        return new PageInfo<>(orgUnitMapper.findUserNotInOrgUnit(vo));
    }

    public PageInfo<OrgUnitUser> findUserInOrgUnit(QueryOrgUnitUserVo vo) {
        if (!StringUtils.isEmpty(vo.getWord())) {
            vo.setWord("%" + vo.getWord() + "%");
        }

        if (!vo.isDisablePaging()) {
            PageHelper.startPage(vo.getPageNum(), vo.getPageSize());
        }
        return new PageInfo<>(orgUnitMapper.findUserInOrgUnit(vo));
    }

    @Transactional
    public Result insertOrgUnitUser(OrgUnitUser orgUnitUser) {
        orgUnitUser.setIsUnitHead(false);
        return new Result(orgUnitMapper.insertOrgUnitUser(orgUnitUser) > 0);
    }

    @Transactional
    public Result deleteOrgUnitUser(OrgUnitUser orgUnitUser) {
        return new Result(orgUnitMapper.deleteOrgUnitUser(orgUnitUser) > 0);
    }

    @Transactional
    public Result setUnitHead(OrgUnitUser orgUnitUser) {
        if (this.removeUnitHead(orgUnitUser).isSuccess()) {
            return new Result(orgUnitMapper.setUnitHead(orgUnitUser) > 0);
        }
        return new Result(false);
    }

    @Transactional
    public Result removeUnitHead(OrgUnitUser orgUnitUser) {
        return new Result(orgUnitMapper.removeUnitHead(orgUnitUser) > 0);
    }

    public List<Integer> findSubordinate(Integer userId) {
        List<Integer> subordinate = orgUnitMapper.findSubordinate(userId);
        if (subordinate == null || subordinate.size() == 0) {
            subordinate.add(userId);
        }
        return subordinate;
    }
}
