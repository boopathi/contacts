(function(window,document,$,undefined){
    $(function(){
	$("#createContact").submit(function(e){
	    e.preventDefault();
	    $.post('./handle', $(this).serialize());
	    return false;
	})
    });
})(this, this.document, jQuery);
	