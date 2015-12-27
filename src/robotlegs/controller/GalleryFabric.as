package robotlegs.controller
{
	import com.greensock.loading.ImageLoader;

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

		public function createItem(loader: ImageLoader): GalleryItem
		{
			var img:DisplayObject = loader.content;
			img.height = Config.IMAGE_HEIGHT;
			img.scaleX = img.scaleY;
			img.alpha = 0;
			var item:GalleryItem = new GalleryItem(loader);
			injector.injectInto(item);
			return item;
		}
	}
}