package ;

import com.saumya.rayTrace.RayTrace;
import flash.Lib;

/**
 * @version 3.0.0
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