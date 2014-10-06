ActiveAdmin.register Membership::Level do
  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :nexudus_id, label: 'Nexudus ID', input_html: { readonly: true }
      f.input :network
    end
    f.actions
  end
end
