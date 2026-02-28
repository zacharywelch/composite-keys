# Adds an opt-in `composite_keys: true` flag to `acts_as_tenant`, so models can
# migrate incrementally to query constraints without changing global behavior.
ActiveSupport.on_load(:active_record) do
  require "acts_as_tenant/model_extensions"

  module ActsAsTenantCompositeKeys
    def acts_as_tenant(tenant = :account, scope = nil, **options)
      composite_keys = options.delete(:composite_keys)
      super

      return unless composite_keys

      fkey = options[:foreign_key] || ActsAsTenant.fkey
      query_constraints fkey.to_sym, *Array(primary_key)
    end
  end

  ActsAsTenant::ModelExtensions::ClassMethods.prepend(ActsAsTenantCompositeKeys)
end
