package ;

import com.saumya.rayTrace.RayTrace;
import nme.Lib;

/**
 * ...
 * @author saumya
 */

class Main 
{
	
	static public function main() 
	{
		Lib.current.addChild(new RayTrace());
	}
	
}