package robotlegs.controller
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;

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
			var loadedUrl:Array = [];
			var url:String = "";
			for (var i:int = 0; i < galleryModel.loadedItems.length; i++)
			{
				url = galleryModel.loadedItems[i].url;
				loadedUrl.push(url);
			}
			while (loadedUrl.indexOf(url) > -1)
			{
				galleryModel.lastLoadedIndex++;
				if (galleryModel.lastLoadedIndex >= galleryModel.linksList.length)
				{
					galleryModel.lastLoadedIndex = 0;
				}
				url = galleryModel.linksList[galleryModel.lastLoadedIndex];
			}

			loader.add(url, onLoad);

			if (!loader.isLoaded)
			{
				loader.load(null);
			}
		}

		private function onLoad(result: LoaderEvent): void
		{
			eventDispatcher.dispatchEvent(new ImageEvent(ImageEvent.IMAGE_READY, result.target.content));
			var item:GalleryItem = galleryFabric.createItem(result.target as ImageLoader);
			galleryModel.loadedItems.push(item);
			var addPoint:Point = event.data as Point;
			item.source.x = addPoint.x;
			item.source.y = addPoint.y;
			item.fadeSignal.dispatch(false, onCreated );
		}

		private function onCreated(): void
		{
			if (!loader.isLoaded)
			{
				eventDispatcher.dispatchEvent(new SystemEvent(SystemEvent.SORT_IMAGES_REQUESTED));
			}
		}

	}
}