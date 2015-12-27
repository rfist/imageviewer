package robotlegs.controller
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;

	import org.robotlegs.mvcs.Command;

	import robotlegs.model.GalleryModel;
	import robotlegs.model.ImageEvent;
	import robotlegs.model.SystemEvent;

	import robotlegs.service.ILoadService;
	import robotlegs.view.GalleryItem;

	/**
	 * LoadImagesCommand.
	 *
	 */
	public class LoadImagesCommand extends Command
	{
		[Inject]
		public var loader:ILoadService;

		[Inject]
		public var galleryModel:GalleryModel;

		[Inject]
		public var galleryFabric:GalleryFabric;

		public function LoadImagesCommand()
		{

		}


		override public function execute():void
		{
			for (var i:int = 0; i < Config.FIRST_QUEUE; i++)
			{
				loader.add(galleryModel.linksList[i], onLoad);
			}
			galleryModel.lastLoadedIndex = i;
			loader.load(onAllImagesLoaded);
		}

		private function onLoad(result: LoaderEvent): void
		{
			eventDispatcher.dispatchEvent(new ImageEvent(ImageEvent.IMAGE_READY, result.target.content));
			var item:GalleryItem = galleryFabric.createItem(result.target as ImageLoader);
			galleryModel.loadedItems.push(item);
		}



		private function onAllImagesLoaded(): void
		{
			eventDispatcher.dispatchEvent(new SystemEvent(SystemEvent.SORT_IMAGES_REQUESTED));
		}
	}
}