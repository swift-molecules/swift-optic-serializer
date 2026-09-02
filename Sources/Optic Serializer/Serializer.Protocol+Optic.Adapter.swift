public import Optic
public import Serializer
public import Serializer_Map

extension Serializer::Serializer.`Protocol` {

    @inlinable
    public func map<Source, Target, Focus, Replacement, ForwardFailure: Swift.Error>(
        backward adapter: Optic::Optic<
            Source,
            Target,
            Focus,
            Replacement
        >.Adapter<ForwardFailure, Never>
    ) -> Serializer::Serializer.Map<Self, Replacement>
    where Output == Target {
        map { replacement in adapter.backward(replacement) }
    }

    @_disfavoredOverload
    @inlinable
    public func map<
        Source,
        Target,
        Focus,
        Replacement,
        ForwardFailure: Swift.Error,
        BackwardFailure: Swift.Error
    >(
        backward adapter: Optic::Optic<
            Source,
            Target,
            Focus,
            Replacement
        >.Adapter<ForwardFailure, BackwardFailure>
    ) -> Serializer::Serializer.Map<Self, Replacement>.Throwing<BackwardFailure>
    where Output == Target {
        tryMap { replacement throws(BackwardFailure) in
            try adapter.backward(replacement)
        }
    }
}
