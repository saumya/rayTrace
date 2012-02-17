package com.saumya.raytrace.components;
import nme.display.Sprite;
import nme.display.Graphics;
import nme.text.TextField;

class ButtonBase extends Sprite
{
	private var t:TextField;
	public function new():Void
	{
		super();
		this.init();
	}
	private function init():Void
	{
		this.drawBG();
		this.t = new TextField();
		this.t.width = 50;
		this.t.selectable = false;
		this.addChild(this.t);
	}
	
	private function drawBG():Void
	{
		var g:Graphics = this.graphics;
		g.clear();
		g.beginFill(0xAAAAAA);
		g.drawRect(0,0,20,20);
	}
	
	public function setLabel(s:String):Void
	{
		this.t.text = s;
	}
	public function setWidth(width:Float):Void
	{
		this.width = width;
		//
		var g:Graphics = this.graphics;
		g.clear();
		g.beginFill(0xAAAAAA);
		g.drawRect(0,0,width,20);
	}
}