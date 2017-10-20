module ActiveAdminAddons
  class ToggleBoolBuilder < CustomBuilder
    SWITCHES_IMAGES_SIZE = "40x16"

    def render
      raise ArgumentError, 'Block should not be used in toggle bool columns' if block
      context.div class: 'toggle-bool-switches-container' do
        [true, false].each do |value|
          context.span switch_image_for value
        end
      end
    end

    def switch_image_for(value)
      img_tag_class = 'toggle-bool-switch'
      img_tag_class += ' hidden-switch' if value == !data
      img_tag_class += ' notify-success' if options[:notify]

      context.image_tag(
        "switches/switch_#{value ? :on : :off}.png",
        size: SWITCHES_IMAGES_SIZE,
        id: "toggle-#{class_name}-#{model.id}-#{attribute}-#{value}",
        class: img_tag_class,
        'data-model': class_name,
        'data-object_id': model.id,
        'data-field': attribute,
        'data-value': value,
        'data-url': context.resource_path(model)
      )
    end
  end
end

ActiveAdminAddons::ToggleBoolBuilder.create_view_methods
