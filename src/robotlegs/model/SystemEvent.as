package robotlegs.model
{
	import flash.events.Event;

	/**
	 * SystemEvent.
	 *
	 */
	public class SystemEvent extends Event
	{
		public static const SHOW_IMAGES_REQUESTED:String = 'show_images_requested';
		public static const LOAD_IMAGES_REQUESTED:String = 'load_images_requested';
		public static const SORT_IMAGES_REQUESTED:String = 'sort_images_requested';
		public static const UPDATE_FIELD_REQUESTED:String = 'update_field_requested';
		public static const CLEAR_LOG_REQUESTED:String = 'clear_log_requested';

		public function SystemEvent(type:String)
		{
			super(type);

		}

		override public function clone():Event
		{
			return new SystemEvent(type);
		}

	}
}