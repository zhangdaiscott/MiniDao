package ${controllerPackage};

import java.util.HashMap;
import java.util.Map;
import com.alibaba.fastjson.JSONObject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.velocity.VelocityContext;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.jeecgframework.p3.core.common.utils.AjaxJson;
import org.jeecgframework.p3.core.page.SystemTools;
import org.jeecgframework.p3.core.util.plugin.ViewVelocity;
import org.jeecgframework.p3.core.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import ${domainPackage}.${className}Entity;
import ${servicePackage}.${className}Service;

 /**
 * 描述：${codeName}
 * @author: ${author}
 * @since：${nowDate}
 * @version:1.0
 */
@Controller
@RequestMapping("/${projectName}/${lowerName}")
public class ${className}Controller extends BaseController{
  @Autowired
  private ${className}Service ${lowerName}Service;
  
	/**
	  * 列表页面
	  * @return
	  */
	@RequestMapping(params = "list",method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute ${className}Entity query,HttpServletRequest request,HttpServletResponse response) throws Exception{
			try {
			 	LOG.info(request, " back list");
				VelocityContext velocityContext = new VelocityContext();
				String viewName = "${projectName}/${bussPackage}/${lowerName}-list.vm";
				ViewVelocity.view(request,response,viewName,velocityContext);
			} catch (Exception e) {
				e.printStackTrace();
			}
}

/**
	 * easyui AJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */

	@RequestMapping(params = "datagrid",method ={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject  datagrid(@ModelAttribute ${className}Entity query,@RequestParam(required = false, value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(required = false, value = "pageSize", defaultValue = "10") int pageSize,HttpServletRequest request, HttpServletResponse response) {
		//分页数据
		MiniDaoPage<${className}Entity> list =${lowerName}Service.getAll(query,pageNo,pageSize);
		Map<String,Object> m=new HashMap<String,Object>();
		m.put("total", list.getTotal());
		m.put("rows", list.getResults());
		JSONObject jsonObject =new JSONObject(m);
		return jsonObject;
	}
	/**
	 * 跳转到添加页面
	 * @return
	 */
	@RequestMapping(params = "toAdd",method ={RequestMethod.GET, RequestMethod.POST})
	public void toAddDialog(HttpServletRequest request,HttpServletResponse response)throws Exception{
		 VelocityContext velocityContext = new VelocityContext();
		 String viewName = "${projectName}/${bussPackage}/${lowerName}-add.vm";
		 ViewVelocity.view(request,response,viewName,velocityContext);
	}

	/**
	 * 保存信息
	 * @return
	 */
	@RequestMapping(params = "doAdd",method ={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public AjaxJson doAdd(@ModelAttribute ${className}Entity ${lowerName}){
		AjaxJson j = new AjaxJson();
		try {
			${lowerName}Service.insert(${lowerName});
			j.setMsg("保存成功");
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg("保存失败");
		    e.printStackTrace();
		}
		return j;
	}

	/**
	 * 跳转到编辑页面
	 * @return
	 */
	@RequestMapping(params="toEdit",method = RequestMethod.GET)
	public void toEdit(@RequestParam(required = true, value = "id" ) String id,HttpServletResponse response,HttpServletRequest request) throws Exception{
			 VelocityContext velocityContext = new VelocityContext();
			 ${className}Entity ${lowerName} = ${lowerName}Service.get(id);
			 velocityContext.put("${lowerName}",${lowerName});
			 String viewName = "${projectName}/${bussPackage}/${lowerName}-edit.vm";
			 ViewVelocity.view(request,response,viewName,velocityContext);
	}

	/**
	 * 编辑
	 * @return
	 */
	@RequestMapping(params = "doEdit",method ={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public AjaxJson doEdit(@ModelAttribute ${className}Entity ${lowerName}){
		AjaxJson j = new AjaxJson();
		try {
			${lowerName}Service.update(${lowerName});
			j.setMsg("编辑成功");
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg("编辑失败");
		    e.printStackTrace();
		}
		return j;
	}


	/**
	 * 删除
	 * @return
	 */
	@RequestMapping(params="doDelete",method = RequestMethod.GET)
	@ResponseBody
	public AjaxJson doDelete(@RequestParam(required = true, value = "id" ) String id){
			AjaxJson j = new AjaxJson();
			try {
				${lowerName}Service.delete(id);
				j.setMsg("删除成功");
			} catch (Exception e) {
				j.setSuccess(false);
				j.setMsg("删除失败");
			    e.printStackTrace();
			}
			return j;
	}
	
	/**
	 * 批量删除数据
	 * @param ids
	 * @return
	 */
	@RequestMapping(params="batchDelete",method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson batchDelete(@RequestParam(required = true, value = "ids") String[] ids) {
		AjaxJson j = new AjaxJson();
		try {
			${lowerName}Service.batchDelete(ids);
			j.setMsg("批量删除成功");
		} catch(Exception e) {
			j.setSuccess(false);
			j.setMsg("批量删除失败");
			e.printStackTrace();
		}
		return j;
	}

}

