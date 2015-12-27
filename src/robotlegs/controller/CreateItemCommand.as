package robotlegs.controller
{
	import com.greensock.events.LoaderEvent;

	import flash.geom.Point;

	import org.robotlegs.mvcs.Command;

	import robotlegs.model.GalleryModel;

	import robotlegs.model.ImageEvent;
	import robotlegs.model.SystemEvent;
	import robotlegs.service.ILoadService;
	import robotlegs.view.GalleryItem;

	/**
	 * DeleteItemCommand.
	 *
	 */
	public class CreateItemCommand extends Command
	{
		[Inject]
		public var event:ImageEvent;

		[Inject]
		public var loader:ILoadService;

		[Inject]
		public var galleryFabric:GalleryFabric;

		[Inject]
		public var galleryModel:GalleryModel;


		public function CreateItemCommand()
		{

		}

		// Methods


		// Event handlers

		override public function execute():void
		{
//			loader.add("http://www.extremetech.com/wp-content/uploads/2013/09/4Vln8-640x428.jpg", onLoad);
			loader.add("http://justsomething.co/wp-content/uploads/2014/04/most-adorable-animals-5.jpg", onLoad);

			// добавить проверку, не загружается ли сейчас
			loader.load(null);
		}

		private function onLoad(result: LoaderEvent): void
		{
			eventDispatcher.dispatchEvent(new ImageEvent(ImageEvent.IMAGE_READY, result.target.content));
			var item:GalleryItem = galleryFabric.createItem(result.target.content);
			galleryModel.loadedItems.push(item);
			var addPoint:Point = event.data as Point;
			item.source.x = addPoint.x;
			item.source.y = addPoint.y;
			item.fadeSignal.dispatch(false, onCreated );

			trace("onCreate");
		}

		private function onCreated(): void
		{
			eventDispatcher.dispatchEvent(new SystemEvent(SystemEvent.SORT_IMAGES_REQUESTED));
//			eventDispatcher.dispatchEvent(new SystemEvent(SystemEvent.UPDATE_FIELD_REQUESTED));
		}

	}
}