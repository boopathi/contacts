(function(window,document,$,undefined){
    $(function(){
	$("#createContact").submit(function(e){
	    e.preventDefault();
	    var that=this;
	    $.post('./handle', $(this).serialize(), function(response){
		var _table = $("#contents table.display");
		var _id = _table.find("tr:last").find("td").html();
		var _name = $(that).find("input[name=name]");
		var _number = $(that).find("input[name=phone]");
		console.log(_name);
		$("#contents table.display").append("<tr><td>"+(parseInt(_id)+1)+"</td><td>"+_name.val()+"</td><td>"+_number.val()+"</td></tr>");
		_name.val("");
		_number.val("");
	    });
	    return false;
	})
    });
})(this, this.document, jQuery);
	
