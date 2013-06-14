function AjaxManager(){
	this.initialize.apply(this, arguments);
};

function ToDoManager(){
	this.initialize.apply(this, arguments);
};

AjaxManager.prototype = {
    initialize:function(args){
    },
	get: function(url, data, callback) {
		$.ajax({
			type:"GET",
        	url: url,
        	data :data,
			timeout: 1000*10,
			error: function(){
			},
        	success:function(result,status){
				callback(result);
        	},
			complete:function(res){
				if (res.status == 200){}else{}
			}
       	});
    },
	
	post: function(url, data, callback) {
		$.ajax({
			type:"POST",
        	url: url,
        	data :data,
			timeout: 1000*10,
			error: function(){
			},
        	success:function(result,status){
				callback(result);
        	},
			complete:function(res){
				if (res.status == 200){}else{}
			}
       	});
    }
}


ToDoManager.prototype = {
    initialize:function(args){
    },
    
    setup_create:function(){
    	var todo_manager = this;
    	$("#id_add_task").click(function(){
	    	var listId = $("#id_list_id").val();
	    	var text   = $("#task_name").val();
	    	var url = "/tasks.json";
	    	if (text=="") return;
    		var data = {"task[list_id]":listId, "task[name]":text};
			ajaxManager.post(url, data, function(result){
				$("#task_name").val("");
				$('<li />', {
					id: 'loader-box',
			        html: '<input type="checkbox" name="todo_id" value="'+result.id+'" class="todo_done">\n<span>'+result.name+'</span>'
				}).addClass("task_list_li").attr("task-id",result.id).appendTo('#task_list').fadeIn("slow").effect("highlight", {}, 1000);
				todo_manager.setup_done();
			});
			return false;
		});

		$("#task_name").keypress(function( e ) {
			var code = (e.keyCode ? e.keyCode : e.which);
			if(code == 13) {
				var listId = $("#id_list_id").val();
		    	var text   = $("#task_name").val();
		    	var url = "/tasks.json";
		    	if (text=="") return;
	    		var data = {"task[list_id]":listId, "task[name]":text};
				ajaxManager.post(url, data, function(result){
					$("#task_name").val("");
					$('<li />', {
						id: 'loader-box',
				        html: '<input type="checkbox" name="todo_id" value="'+result.id+'" class="todo_done">\n<span>'+result.name+'</span>'
					}).addClass("task_list_li").attr("task-id",result.id).appendTo('#task_list').fadeIn("slow").effect("highlight", {}, 1000);
					todo_manager.setup_done();
				});
			}
		});
    },

    setup_done:function(){
    	var todo_manager = this;
    	$(".todo_done").unbind('click');
    	$(".todo_done").click(function(){
	    	var todoId = $(this).val();
	    	var url = "/tasks/done.json";
	    	var data = {"id":todoId};
	    	var liEl = $(this).parent();
	    	ajaxManager.post(url, data, function(result){
	    		liEl.remove();
				$('<li />', {
					id: 'loader-box', 
			        html: '<input type="checkbox" name="todo_id" value="'+result.id+'" class="todo_undone" checked><span>'+result.name+'</span>'
				}).prependTo('#done_list').fadeIn("slow").effect("highlight", {}, 1000);
				todo_manager.setup_undone();
			});
			return true;
    	});
    },

    setup_undone:function(){
    	var todo_manager = this;
    	$(".todo_undone").unbind('click');
    	$(".todo_undone").click(function(){
	    	var todoId = $(this).val();
	    	var url = "/tasks/undone.json";
	    	var data = {"id":todoId};
	    	var liEl = $(this).parent();
	    	ajaxManager.post(url, data, function(result){
	    		liEl.remove();
				$('<li />', {
					id: 'loader-box',  
			        html: '<input type="checkbox" name="todo_id" value="'+result.id+'" class="todo_done"><span>'+result.name+'</span>'
				}).appendTo('#task_list').fadeIn("slow").effect("highlight", {}, 1000);
				todo_manager.setup_done();
			});
			return true;
    	});
    },

    setup_sort:function(){
    	$("#task_list").sortable({ items: 'li', cursor: 'move', opacity: 0.6 ,
			start: function(event, ui) { },
	        change: function(event, ui) { },
	        update: function(event, ui) {
		    	var url = "/tasks/sort.json";
		    	var todoIds = [];
		    	var prioritys = [];
		    	$('.task_list_li').each(function(index, domEle){
        		    todoIds.push($(this).attr('task-id'));
        		    prioritys.push(index+1);
		        });
		    	var data = {todo_ids:todoIds, prioritys:prioritys};
		    	ajaxManager.post(url, data, function(result){
					console.log(result);
				});
			}
		});
		$("#task_list").disableSelection();
    },

    setup_delete:function(){
    	$(".todo_delete").unbind('click');
    	$(".todo_delete").click(function(){
	    	var liEl = $(this).parent();
	    	liEl.remove();
			return false;
    	});
    },

    setup_additem_link: function(){
    	$("#add-item-link").unbind('click');
    	$("#add-item-link").click(function(){
    		$("#additem").show();
    		$("#additem-link").hide();
    		$("#close-item-link").click(function(){
    			$("#additem").hide();
    			$("#additem-link").show();
    			return false;
    		});
    		return false;
    	});
    },

	create:function(){

	}

};

var ajaxManager;
var todoManager;

jQuery(function($){
	ajaxManager = new AjaxManager();
	todoManager = new ToDoManager();
	todoManager.setup_create();
	todoManager.setup_done();
	todoManager.setup_undone();
	todoManager.setup_sort();
	todoManager.setup_delete();
	todoManager.setup_additem_link();
});
