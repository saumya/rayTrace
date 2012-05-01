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
import minimalcomps.InputText;
import flash.errors.ArgumentError;

/**
 * @version 4.0.1
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
	private var connectionNameText:InputText;
	private var isInAdvancedMode:Bool;
	private var channelInfo:Label;
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
		this.channelInfo=new Label(this,70,415,'Connection name : _RayTrace_V4.0.0_');
		//
		clearBtn.addEventListener(MouseEvent.CLICK, onClear);
		dnBtn.addEventListener(MouseEvent.CLICK, onDown);
		upBtn.addEventListener(MouseEvent.CLICK, onUp);
		//test button
		var testBtn:PushButton=new PushButton(this,645,0,'test');
		testBtn.setSize(40,20);
		testBtn.visible=false;
		testBtn.addEventListener(MouseEvent.CLICK, onTest);
		//
		this.scrollTrack=new PushButton(this,605,25,'');
		this.scrollTrack.setSize(20,20);
		this.scrollTrack.addEventListener(MouseEvent.MOUSE_DOWN, onScrollMouseDown);
		this.scrollTrack.addEventListener(MouseEvent.MOUSE_UP, onScrollMouseUp);
		this.scrollTrack.addEventListener(MouseEvent.MOUSE_MOVE, onScrollMouseMove);
		this.shouldScroll = false;
		this.scrollTrack.visible=false;
		upBtn.visible=dnBtn.visible=false;
		//
		this.logNumber = 0;
		this.logMessage = '';
		//
		this.t=new Text(this,0,0,'Hello Text');
		this.t.setSize(600,400);
		this.t.text='RayTrace V4.0.0';
		//
		var btnStart:PushButton=new PushButton(this,555,415,'Start');
		var btnStop:PushButton=new PushButton(this,600,415,'Stop');
		btnStart.setSize(40,20);
		btnStop.setSize(40,20);
		//
		btnStart.addEventListener(MouseEvent.CLICK, onStart);
		btnStop.addEventListener(MouseEvent.CLICK, onStop);
		//
		var btnAdvancedSettings:PushButton=new PushButton(this,250,415,'Advanced');
		btnAdvancedSettings.setSize(50,20);
		btnAdvancedSettings.addEventListener(MouseEvent.CLICK, onAdvancedSetting);
		this.connectionNameText=new InputText(this,310,415,'_RayTrace_V4.0.0_');
		this.connectionNameText.setSize(200,20);
		this.connectionNameText.visible=false;
		this.isInAdvancedMode=false;
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
	
	private function onAdvancedSetting(e:MouseEvent):Void
	{
		this.isInAdvancedMode=(! this.isInAdvancedMode);
		this.connectionNameText.visible=(! this.connectionNameText.visible);
		this.channelInfo.visible=(! this.channelInfo.visible);
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
		var connectionName:String='';
		if(this.isInAdvancedMode==true)
		{
			connectionName=this.connectionNameText.text;
		}else{
			connectionName='_RayTrace_V4.0.0_';
		}
		//this.lc.connect(connectionName);
		try{
			this.lc.connect(connectionName);
			this.log(connectionName);
			this.log('Logger Started.');
		}catch(e:ArgumentError)
		{
			this.log(e.toString());
			this.log('Already Running ! What you want to do ?!');
		}
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
		this.log('onTest : checking');
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
		this.logMessage = 'RayTrace V4.0.0';
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