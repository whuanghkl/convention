package com.girltest.web.controller;

import com.common.dict.Constant2;
import com.girltest.dao.ConventionDao;
import com.girltest.dao.Test2BoyDao;
import com.girltest.entity.Convention;
import com.girltest.entity.Test2Boy;
import com.girltest.util.ConventionUtil;
import com.time.util.TimeHWUtil;
import oa.web.controller.base.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/***
 *
 */
@Controller
@RequestMapping("/convention")
public class ConventionController extends BaseController<Convention> {
    private Test2BoyDao test2BoyDao;

    @Override
    protected void beforeAddInput(Model model) {
    }

    @Override
    protected void errorDeal(Model model) {
    }

    @Override
    public String getJspFolder() {
        return "convention";
    }

    @ResponseBody
    @RequestMapping(value = "/{id}/delete2/json")
    public String deleteOne(@PathVariable int id, Model model, HttpServletRequest request, String targetView) {
        init(request);
        ConventionDao conventionDao = (ConventionDao) this.getDao();
        conventionDao.deleteConvention(id);
        return Constant2.RESPONSE_RIGHT_RESULT;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String update(int id, Convention roleLevel, int testBoyId, Model model, HttpServletRequest request) throws SecurityException, NoSuchFieldException, IllegalArgumentException, IllegalAccessException {
        ConventionDao conventionDao = (ConventionDao) this.getDao();
        Convention convention = conventionDao.get(id);
        convention.setUpdateTime(TimeHWUtil.getCurrentDateTime());
        convention.setAnswer(roleLevel.getAnswer());
        updateCommon(id, convention, model, request);
        test2BoyDao.updateTime(testBoyId);

        roleLevel.setAnswer(ConventionUtil.convertBr(roleLevel.getAnswer()));
        Test2Boy test2Boy = test2BoyDao.get(testBoyId);
        model.addAttribute("test", test2Boy);
        return getJspFolder() + "/detail";
    }

    @RequestMapping(value = "/add_answer")
    public String addAnswer(int testBoyId, Model model, HttpServletRequest request) throws SecurityException, NoSuchFieldException, IllegalArgumentException, IllegalAccessException {
        Test2Boy test2Boy = test2BoyDao.get(testBoyId);
        model.addAttribute("test", test2Boy);
        return getJspFolder() + "/add";
    }

    @RequestMapping("/edit")
    public String editAnswer(Model model, HttpServletRequest request, Test2Boy test2Boy, int testBoyId, int conventionId) {
        init(request);
        test2Boy.setId(testBoyId);
        ConventionDao conventionDao = (ConventionDao) this.getDao();
        Convention convention = conventionDao.get(conventionId);
        model.addAttribute("test", test2Boy);
        model.addAttribute("convention", convention);
        return "convention/edit";
    }

    public Test2BoyDao getTest2BoyDao() {
        return test2BoyDao;
    }

    @Resource
    public void setTest2BoyDao(Test2BoyDao test2BoyDao) {
        this.test2BoyDao = test2BoyDao;
    }
}
