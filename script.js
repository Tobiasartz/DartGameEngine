var OBJECTS = {
		player : {},
		obstacles : {
			objects : []
		},
		destroyables : {
			objects : []
		},
		enemies : {
			objects : []
		}
};

var GEGRAPHIC = {
		x : null,
		y : null,
		z : null,
		width : 30,
		height : 30
}

$('document').ready(function(){
  
	$('.addPlayer').click(function(e){
	  var player = $.extend({},GEGRAPHIC);
	  createNewVisualObject(player, 'player');
	  
	  OBJECTS.player = player;
	});
	
	$('.addObstacle').click(function(e){
		e.preventDefault();
		var obstacle = $.extend({},GEGRAPHIC);
		createNewVisualObject(obstacle, 'obstacle');
		  
		OBJECTS.obstacles.objects.push(obstacle);
	});
	
	$('.addDestroyable').click(function(e){
		e.preventDefault();
		var destroyable = $.extend({},GEGRAPHIC);
		createNewVisualObject(destroyable,'destroyable');
		  
		OBJECTS.destroyables.objects.push(destroyable);
	});	
	
	$('.addEnemy').click(function(e){
		e.preventDefault();
		var enemy = $.extend({},GEGRAPHIC);
		createNewVisualObject(enemy);
		  
		OBJECTS.enemies.objects.push(enemy,'enemy');
	});
	
	$('.save').click(function(e){
		$('.output').empty();
		$('.output').append(JSON.stringify(OBJECTS));
		document.getElementById('game').contentDocument.location.reload(true);
	});	
    
});

function createNewVisualObject(object, className){
	var grid = 5;
	var DOM = $('.GEGraphic.template').clone(false);
	DOM.addClass(className);
	DOM.css('position','absolute');
	DOM.css('top',0);
	DOM.css('left',0);
	
	DOM.removeClass('template');
	DOM.removeClass('hidden');
	
	DOM.draggable({ 
		grid: [ grid,grid ],
		containment: "parent",
		stop : function(event, ui){
			object.x = $(this).position().left;
			object.y = $(this).position().top;
			console.log(OBJECTS);
		}
	});
	  
	DOM.resizable({
		containment: "parent",
		handles: "n, ne, e, se, s, w, nw",
		grid: grid,
		stop : function(event, ui){
			object.x = $(this).position().left;
			object.y = $(this).position().top;
			object.width = $(this).width();
			object.height = $(this).height();
		}
	});
	
	$('.visualEditor').append(DOM);
}