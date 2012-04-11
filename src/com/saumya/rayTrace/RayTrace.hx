package com.saumya.rayTrace;

import com.saumya.raytrace.components.ButtonBase;
import flash.events.Event;
import flash.events.StatusEvent;
import flash.net.LocalConnection;

import flash.display.Sprite;
import flash.text.TextField;
import flash.events.MouseEvent;

import minimalcomps.PushButton;
import minimalcomps.Label;
import minimalcomps.Text;

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
	private var t:Text;
	//
	private var scrollTrack:PushButton;
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
		var upBtn:PushButton=new PushButton(this,605,0,'up');
		upBtn.setSize(30,20);
		var dnBtn:PushButton=new PushButton(this,605,380,'dn');
		dnBtn.setSize(30,20);
		var clearBtn:PushButton=new PushButton(this,0,410,'clear');
		clearBtn.setSize(50,20);
		//chanel info
		var channelInfo:Label=new Label(this,70,415,'Connection name : _RayTrace_V4.0.0_');
		//
		clearBtn.addEventListener(MouseEvent.CLICK, onClear);
		dnBtn.addEventListener(MouseEvent.CLICK, onDown);
		upBtn.addEventListener(MouseEvent.CLICK, onUp);
		//test button
		var testBtn:PushButton=new PushButton(this,645,0,'test');
		testBtn.setSize(40,20);
		//testBtn.visible=false;
		testBtn.addEventListener(MouseEvent.CLICK, onTest);
		//
		this.scrollTrack=new PushButton(this,605,25,'');
		this.scrollTrack.setSize(20,20);
		this.scrollTrack.addEventListener(MouseEvent.MOUSE_DOWN, onScrollMouseDown);
		this.scrollTrack.addEventListener(MouseEvent.MOUSE_UP, onScrollMouseUp);
		this.scrollTrack.addEventListener(MouseEvent.MOUSE_MOVE, onScrollMouseMove);
		this.shouldScroll = false;
		//
		this.logNumber = 0;
		this.logMessage = '';
		//
		this.t=new Text(this,0,0,'Hello Text');
		this.t.setSize(600,400);
		this.t.text='RayTrace V 4.0.0';
		//
		var btnStart:ButtonBase = new ButtonBase();
		btnStart.setLabel('start');
		btnStart.setWidth(50);
		btnStart.setBgColor(0x00FF00);
		btnStart.x = 490;
		btnStart.y = 415;
		var btnStop:ButtonBase = new ButtonBase();
		btnStop.setLabel('stop');
		btnStop.setWidth(50);
		btnStop.setBgColor(0xFF0000);
		btnStop.x = 545;
		btnStop.y = 415;
		//
		btnStart.addEventListener(MouseEvent.CLICK, onStart);
		btnStop.addEventListener(MouseEvent.CLICK, onStop);
		//
		this.addChild(btnStop);
		this.addChild(btnStart);
		//
		this.lc = new LocalConnection();
		this.lc.client = this;
		//this.lc.addEventListener(flash.events.StatusEvent.STATUS, onStatusUpdate);
		/*
		//connect
		this.lc = new LocalConnection();
		this.lc.client = this;
		//this.lc.send('_RayTrace_V1.0.0_', 'log', message);
		this.lc.connect('_RayTrace_V2.0.0_');
		//
		//this.lc.send('_RayTrace_V1.0.0_','log','hello');
		*/
	}
	
	private function onStatusUpdate(e:StatusEvent):Void 
	{
		this.log('status: level='+ e.level);
	}
	
	private function onStop(e:MouseEvent):Void 
	{
		this.lc.close();
		this.log('Logger Stopped.');
	}
	
	private function onStart(e:MouseEvent):Void 
	{
		//connect
		//this.lc = new LocalConnection();
		//this.lc.client = this;
		this.lc.connect('_RayTrace_V3.0.0_');
		//
		this.log('Logger Started.');
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
			/*
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
			*/
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
		//this.log('hello : max scroll='+this.t.maxScrollV);
		this.log('onTest : ');
	}
	
	private function onUp(e:MouseEvent):Void 
	{
		//this.t.scrollV--;
	}
	
	private function onDown(e:MouseEvent):Void 
	{
		//this.t.scrollV++;
	}
	
	private function onClear(e:MouseEvent):Void 
	{
		this.logNumber = 0;
		this.logMessage = 'RayTrace V3.0.0';
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