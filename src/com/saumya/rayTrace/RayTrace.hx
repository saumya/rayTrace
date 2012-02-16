package com.saumya.rayTrace;
//import haxe.remoting.LocalConnection;
import com.saumya.raytrace.components.ButtonBase;
import flash.net.LocalConnection;

import nme.display.Sprite;
import nme.text.TextField;

/**
 * @version 1.0.0
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
		var upBtn:ButtonBase = new ButtonBase();
		upBtn.setLabel('up');
		upBtn.setWidth(30);
		upBtn.x = 405;
		this.addChild(upBtn);
		var dnBtn:ButtonBase = new ButtonBase();
		dnBtn.setLabel('dn');
		dnBtn.setWidth(30);
		dnBtn.x = 405;
		dnBtn.y = 380;
		this.addChild(dnBtn);
		var clearBtn:ButtonBase = new ButtonBase();
		clearBtn.setLabel('clear');
		clearBtn.setWidth(50);
		clearBtn.x = 10;
		clearBtn.y = 400;
		this.addChild(clearBtn);
		//
		this.logNumber = 0;
		this.logMessage = '';
		//
		this.t = new TextField();
		this.t.multiline = true;
		this.t.wordWrap = true;
		this.t.selectable = true;
		this.t.width = 400;
		this.t.height = 400;
		this.t.text = 'RayTrace V 2.0.0';
		this.t.background = true;
		this.t.backgroundColor = 0xEEEEEE;
		
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