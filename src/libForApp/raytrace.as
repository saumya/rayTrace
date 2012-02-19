package
{
	import flash.net.LocalConnection;
	
	public function raytrace(message:String):void
	{
		var connectionName:String='_RayTrace_V2.0.0_';
		var lc:LocalConnection=new LocalConnection();
		lc.send(connectionName,'log',message);
	}
}

