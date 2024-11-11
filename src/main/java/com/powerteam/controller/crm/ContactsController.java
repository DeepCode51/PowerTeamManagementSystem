package com.powerteam.controller.crm;

import com.github.pagehelper.PageInfo;
import com.powerteam.controller.AuthorizedController;
import com.powerteam.model.crm.Contacts;
import com.powerteam.service.crm.ContactsService;
import com.powerteam.vo.Result;
import com.powerteam.vo.crm.QueryContactsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/contacts")
public class ContactsController extends AuthorizedController {

    @Autowired
    private ContactsService contactsService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String customer() {
        return "crm/contacts";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Result add(@RequestBody Contacts contacts) {
        contacts.setCreateBy(getUser().getUserId());
        return contactsService.insert(contacts);
    }

    @RequestMapping(value = "/find", method = RequestMethod.POST)
    @ResponseBody
    public PageInfo<Contacts> find(@RequestBody QueryContactsVo vo) {
        return contactsService.find(vo);
    }

    @RequestMapping(value = "/findById", method = RequestMethod.POST)
    @ResponseBody
    public Contacts findById(@RequestBody Contacts contacts) {
        return contactsService.findById(contacts.getContactsId());
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Result update(@RequestBody Contacts contacts) {
        return contactsService.update(contacts);
    }
}
