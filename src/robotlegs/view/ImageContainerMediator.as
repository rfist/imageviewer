package robotlegs.view
{
	import flash.display.DisplayObject;

	import org.robotlegs.mvcs.Mediator;

	import robotlegs.model.ImageEvent;

	import robotlegs.model.SystemEvent;


	/**
	 * ImageContainerMediator.
	 *
	 */
	public class ImageContainerMediator extends Mediator
	{
		[Inject]
		public var imageContainer:ImageContainer;

		public function ImageContainerMediator()
		{

		}


		override public function onRegister():void
		{
			eventDispatcher.dispatchEvent(new SystemEvent(SystemEvent.LOAD_IMAGES_REQUESTED));
			eventMap.mapListener(eventDispatcher, ImageEvent.IMAGE_READY, onImageReady);
		}

		private function onImageReady(event:ImageEvent):void
		{
			imageContainer.addChild(event.data as DisplayObject);
		}
	}
}