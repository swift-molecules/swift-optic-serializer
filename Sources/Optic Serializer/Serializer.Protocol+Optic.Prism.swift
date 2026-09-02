public import Either
public import Optic
public import Serializer
public import Serializer_Map

extension Serializer::Serializer.`Protocol` {

    @inlinable
    public func map<Source, Target, Focus, Replacement>(
        embedding prism: Optic::Optic<
            Source,
            Target,
            Focus,
            Replacement
        >.Prism
    ) -> Serializer::Serializer.Map<Self, Replacement>
    where Output == Target {
        contramap { replacement in prism.embed(copy replacement) }
    }

    @inlinable
    public func map<Source, Target, Focus, Replacement>(
        matching prism: Optic::Optic<
            Source,
            Target,
            Focus,
            Replacement
        >.Prism
    ) -> Serializer::Serializer.Map<Self, Source>
    where Output == Either<Target, Focus> {
        contramap { source in prism.match(copy source) }
    }

    @_disfavoredOverload
    @inlinable
    public func map<Source, Target, Focus, Replacement, MatchFailure: Swift.Error>(
        matching prism: Optic::Optic<
            Source,
            Target,
            Focus,
            Replacement
        >.Prism,
        failure transform: @escaping (consuming Target) -> MatchFailure
    ) -> Serializer::Serializer.Map<Self, Source>.Throwing<MatchFailure>
    where Output == Focus {
        contramap { source throws(MatchFailure) in
            switch prism.match(copy source) {
            case .left(let target):
                throw transform(target)
            case .right(let focus):
                return focus
            }
        }
    }
}
