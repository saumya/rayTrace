package com.saumya.rayTrace;
//import haxe.remoting.LocalConnection;
import com.saumya.raytrace.components.ButtonBase;
import flash.net.LocalConnection;

import nme.display.Sprite;
import nme.text.TextField;
import nme.events.MouseEvent;

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
	//
	private var scrollTrack:ButtonBase;
	private var shouldScroll:Bool;
	//
	private var lastPosY:Float;
	
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
		upBtn.x = 605;
		this.addChild(upBtn);
		var dnBtn:ButtonBase = new ButtonBase();
		dnBtn.setLabel('dn');
		dnBtn.setWidth(30);
		dnBtn.x = 605;
		dnBtn.y = 380;
		this.addChild(dnBtn);
		var clearBtn:ButtonBase = new ButtonBase();
		clearBtn.setLabel('clear');
		clearBtn.setWidth(50);
		clearBtn.x = 0;
		clearBtn.y = 410;
		this.addChild(clearBtn);
		//
		clearBtn.addEventListener(MouseEvent.CLICK, onClear);
		dnBtn.addEventListener(MouseEvent.CLICK, onDown);
		upBtn.addEventListener(MouseEvent.CLICK, onUp);
		//
		var testBtn:ButtonBase = new ButtonBase();
		testBtn.setLabel('test');
		testBtn.setWidth(30);
		testBtn.x = 645;
		this.addChild(testBtn);
		testBtn.addEventListener(MouseEvent.CLICK, onTest);
		//
		this.scrollTrack=new ButtonBase();
		this.scrollTrack.setLabel('');
		this.scrollTrack.setWidth(30);
		this.scrollTrack.x=605;
		this.scrollTrack.y=25;
		this.addChild(this.scrollTrack);
		this.scrollTrack.addEventListener(MouseEvent.MOUSE_DOWN, onScrollMouseDown);
		this.scrollTrack.addEventListener(MouseEvent.MOUSE_UP, onScrollMouseUp);
		this.scrollTrack.addEventListener(MouseEvent.MOUSE_MOVE, onScrollMouseMove);
		this.shouldScroll = false;
		//
		this.logNumber = 0;
		this.logMessage = '';
		//
		this.t = new TextField();
		this.t.multiline = true;
		this.t.wordWrap = true;
		this.t.selectable = true;
		this.t.width = 600;
		this.t.height = 400;
		this.t.text = 'RayTrace V 2.0.0';
		this.t.background = true;
		this.t.backgroundColor = 0xEEEEEE;
		
		this.addChild(this.t);
		//connect
		this.lc = new LocalConnection();
		this.lc.client = this;
		//this.lc.send('_RayTrace_V1.0.0_', 'log', message);
		this.lc.connect('_RayTrace_V2.0.0_');
		//
		//this.lc.send('_RayTrace_V1.0.0_','log','hello');
		
	}
	
	private function onScrollMouseMove(e:MouseEvent):Void 
	{
		var currentPosY:Float = e.stageY;
		//check for the scroll direction
		if (this.shouldScroll)
		{
			/*
			//this.log('onScrollMouseMove');
			//this.log('currentPosY=' + currentPosY + ' :: lastPos=' + this.lastPosY);
			if (currentPosY>this.lastPosY)
			{
				//moves the text up
				this.t.scrollV++;
			}else {
				//moves the text down
				this.t.scrollV--;
			}
			
			//update the last position
			this.lastPosY = currentPosY;
			*/
			var ms:Int = this.t.maxScrollV;
			var scrollHeight = (350 - 30); // min pos=30, max pos=360
			var percentScroll:Int = Math.ceil((ms / scrollHeight) * (this.scrollTrack.y));
			this.t.scrollV = percentScroll;
			//
			this.scrollTrack.y = this.mouseY - (this.scrollTrack.height / 2);
			//restricts the scroll track
			if (this.scrollTrack.y<=30)
			{
				this.scrollTrack.y = 30;
			}else if(this.scrollTrack.y>=350) {
				this.scrollTrack.y = 350;
			}
			
		}
		
	}
	
	private function onScrollMouseUp(e:MouseEvent):Void 
	{
		//this.log('onScrollMouseUp');
		this.shouldScroll = false;
		//
		this.lastPosY = this.mouseY;
	}
	
	private function onScrollMouseDown(e:MouseEvent):Void 
	{
		//this.log('onScrollMouseDown');
		this.shouldScroll = true;
	}
	
	private function onTest(e:MouseEvent):Void 
	{
		this.log('hello : max scroll='+this.t.maxScrollV);
	}
	
	private function onUp(e:MouseEvent):Void 
	{
		this.t.scrollV++;
	}
	
	private function onDown(e:MouseEvent):Void 
	{
		this.t.scrollV--;
	}
	
	private function onClear(e:MouseEvent):Void 
	{
		this.logNumber = 0;
		this.logMessage = 'RayTrace V2.0.0';
		this.t.text = this.logMessage;
	}
	
	public function log(message:String):Void
	{
		var s:String = this.t.text;
		this.logNumber++;
		//this.logMessage = message + '\n' + this.logNumber + ' : ' + s;
		this.t.text = this.logNumber+' : '+message + '\n' + s;
	}
	
	
}