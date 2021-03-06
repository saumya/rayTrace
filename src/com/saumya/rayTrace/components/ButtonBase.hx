package com.saumya.raytrace.components;
import flash.display.Sprite;
import flash.display.Graphics;
import flash.text.TextField;

class ButtonBase extends Sprite
{
	private var t:TextField;
	private var bgColor:Int;
	//
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
		this.t.height = 20;
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
	
	public function setBgColor(color:Int):Void
	{
		this.bgColor = color;
		//
		var g:Graphics = this.graphics;
		g.clear();
		g.beginFill(this.bgColor);
		g.drawRect(0,0,this.width,20);
	}
}