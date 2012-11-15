package com.saumya.rayTrace;

import com.saumya.raytrace.components.ButtonBase;
import flash.events.Event;
import flash.events.StatusEvent;
import flash.errors.ArgumentError;
import flash.net.LocalConnection;

import flash.display.Sprite;
import flash.text.TextField;
import flash.events.MouseEvent;

import minimalcomps.PushButton;
import minimalcomps.Label;
import minimalcomps.Text;
import minimalcomps.InputText;
import minimalcomps.Panel;
import minimalcomps.VSlider;

/**
 * @version 4.1.0
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
	private var shouldScroll:Bool;
	//
	private var p:Panel;
	private var vs:VSlider;
	
	public function new() 
	{
		super();
		this.init();
	}
	public function init():Void
	{
		this.p=new Panel(this, 0, 0);
		p.setSize(640,400);
		p.setColor(0xAAAAAA);
		this.vs=new VSlider(this.p, 630, 0,onUserSlide);
		this.vs.setSize(15,400);
		this.vs.setSliderParams(0,590,590);
		var clearBtn:PushButton=new PushButton(this,0,410,'clear');
		clearBtn.setSize(50,20);
		//chanel info
		this.channelInfo=new Label(this,70,415,'Connection name : _RayTrace_V4.1.0_');
		//
		clearBtn.addEventListener(MouseEvent.CLICK, onClear);
		//test button
		var testBtn:PushButton=new PushButton(this,645,0,'test');
		testBtn.setSize(40,20);
		testBtn.visible=false;//test button
		testBtn.addEventListener(MouseEvent.CLICK, onTest);
		//
		this.logNumber = 0;
		this.logMessage = '';
		//
		this.t=new Text(this,10,10,'Hello Text');
		//this.t=new Text(p,50,50,'Hello Text');
		this.t.setSize(610,380);
		this.t.text='RayTrace V4.1.0';
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
		this.connectionNameText=new InputText(this,310,415,'_RayTrace_V4.1.0_');
		this.connectionNameText.setSize(200,20);
		this.connectionNameText.visible=false;
		this.isInAdvancedMode=false;
		//
		this.lc = new LocalConnection();
		this.lc.allowDomain('*');
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
			connectionName='_RayTrace_V4.1.0_';
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
	
	private function onTest(e:MouseEvent):Void 
	{
		//this.log('hello : max scroll='+this.t.maxScrollV);
		this.log('onTest : checking');
	}
	
	private function onClear(e:MouseEvent):Void 
	{
		this.logNumber = 0;
		this.logMessage = 'RayTrace V4.1.0';
		this.t.text = this.logMessage;
	}
	private function onUserSlide(e:Event):Void{
		//this.log(this.vs.getValue()+'');
		var tf:TextField=this.t.getTextField();
		var min:Int=0;
		var max:Int=tf.maxScrollV;
		var percent:Float=(max/400)*(this.vs.getValue());
		var n:Int=Math.round(percent);
		tf.scrollV=n;
	}
	
	public function log(message:String):Void
	{
		var s:String = this.t.text;
		this.logNumber++;
		//this.logMessage = message + '\n' + this.logNumber + ' : ' + s;
		this.t.text = this.logNumber+' : '+message + '\n' + s;
		/*
		var tf:TextField=this.t.getTextField();
		this.vs.setValue(tf.maxScrollV);
		 */
		 //TODO: Fix the scroll position
	}
	
	
}