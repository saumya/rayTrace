package com.saumya.rayTrace;
//import haxe.remoting.LocalConnection;
import flash.net.LocalConnection;

import nme.display.Sprite;
import nme.text.TextField;

/**
 * ...
 * @author saumya
 */

class RayTrace extends Sprite
{
	private var lc:LocalConnection;
	//
	private var logNumber:Int;
	private var logMessage:String;
	//
	private var t:TextField;
	
	public function new() 
	{
		super();
		this.init();
	}
	public function init():Void
	{
		this.logNumber = 0;
		this.logMessage = '';
		//
		this.t = new TextField();
		this.t.multiline = true;
		this.t.wordWrap = true;
		this.t.selectable = true;
		this.t.width = 400;
		this.t.height = 400;
		this.t.text = 'RayTrace V 1.0.0';
		this.addChild(this.t);
		//connect
		this.lc = new LocalConnection();
		this.lc.client = this;
		//this.lc.send('_RayTrace_V1.0.0_', 'log', message);
		this.lc.connect('_RayTrace_V1.0.0_');
		//
		//this.lc.send('_RayTrace_V1.0.0_','log','hello');
		
	}
	public function log(message:String):Void
	{
		var s:String = this.t.text;
		this.logNumber++;
		//this.logMessage = message + '\n' + this.logNumber + ' : ' + s;
		this.t.text = this.logNumber+' : '+message + '\n' + s;
	}
	
	
}