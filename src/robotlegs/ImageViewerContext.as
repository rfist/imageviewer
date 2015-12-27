package robotlegs
{
	import org.robotlegs.mvcs.Context;

	import robotlegs.controller.CreateItemCommand;
	import robotlegs.controller.DeleteItemCommand;
	import robotlegs.controller.GalleryFabric;
	import robotlegs.controller.LoadImagesCommand;
	import robotlegs.controller.ShowImagesCommand;
	import robotlegs.controller.SortByWidthCommand;
	import robotlegs.controller.UpdateFieldCommand;

	import robotlegs.model.GalleryModel;
	import robotlegs.model.ImageEvent;
	import robotlegs.model.SystemEvent;
	import robotlegs.service.ILoadService;
	import robotlegs.service.ImageLoaderService;
	import robotlegs.view.GalleryItem;

	import robotlegs.view.ImageContainer;

	import robotlegs.view.ImageContainerMediator;

	/**
	 * ImageViewerContext.
	 *
	 */
	public class ImageViewerContext extends Context
	{

		public function ImageViewerContext()
		{
			super();
		}

		override public function startup():void
		{
			// Controller
//			commandMap.mapEvent(SystemEvent.CLEAR_LOG_REQUESTED, TryClearMessages);
			commandMap.mapEvent(SystemEvent.SHOW_IMAGES_REQUESTED, ShowImagesCommand);
			commandMap.mapEvent(SystemEvent.LOAD_IMAGES_REQUESTED, LoadImagesCommand);
			commandMap.mapEvent(SystemEvent.SORT_IMAGES_REQUESTED, SortByWidthCommand);
			commandMap.mapEvent(SystemEvent.UPDATE_FIELD_REQUESTED, UpdateFieldCommand);
			commandMap.mapEvent(ImageEvent.CREATE_NEW_REQUESTED, CreateItemCommand, ImageEvent);
			commandMap.mapEvent(ImageEvent.DELETE_ITEM_REQUESTED, DeleteItemCommand, ImageEvent);
			// Model
			injector.mapSingleton(GalleryModel);
			injector.mapSingleton(GalleryFabric);
//			injector.mapSingleton(UserProxy);
//			injector.mapSingleton(MessageModel);
			// Services
			injector.mapSingletonOf(ILoadService, ImageLoaderService);
//			injector.mapSingletonOf(IAuthService, DummyAuthService);
			// View
			mediatorMap.mapView(ImageContainer, ImageContainerMediator);
			mediatorMap.mapView(GalleryItem, GalleryItem);
			// Startup complete
			super.startup();
		}

	}
}