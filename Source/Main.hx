package ;

import com.saumya.rayTrace.RayTrace;
//import nme.Lib;
import flash.Lib;

/**
 * @version 2.0.0
 * @author saumya
 */

class Main 
{
	
	static public function main() 
	{
		var r:RayTrace = new RayTrace();
		r.x = 10;
		r.y = 10;
		Lib.current.addChild(r);
	}
	
}