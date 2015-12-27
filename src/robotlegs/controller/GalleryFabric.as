package robotlegs.controller
{
	import flash.display.DisplayObject;

	import org.robotlegs.mvcs.Command;

	import robotlegs.view.GalleryItem;

	/**
	 * GalleryFabric.
	 *
	 */
	public class GalleryFabric extends Command
	{

		// Class constants
		// Class variables
		// Class methods

		// Variables

		//private var :;
		//private var Array:Array = [];

		// Properties

		// Constructor

		public function GalleryFabric()
		{

		}

		public function createItem(img: DisplayObject): GalleryItem
		{
			img.height = Config.IMAGE_HEIGHT;
			img.scaleX = img.scaleY;
			img.alpha = 0;
			var item:GalleryItem = new GalleryItem(img);
			injector.injectInto(item);
			return item;
		}
	}
}