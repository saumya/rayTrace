package ;

import com.saumya.rayTrace.RayTrace;
import nme.Lib;

/**
 * @version 2.0.0
 * @author saumya
 */

class Main 
{
	
	static public function main() 
	{
		Lib.current.addChild(new RayTrace());
	}
	
}