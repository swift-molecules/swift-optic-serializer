public import Optic
public import Serializer
public import Serializer_Map

extension Serializer::Serializer.`Protocol` {

    @inlinable
    public func map<Source, Target, Focus, Replacement>(
        backward isomorphism: Optic::Optic<
            Source,
            Target,
            Focus,
            Replacement
        >.Isomorphism
    ) -> Serializer::Serializer.Map<Self, Replacement>
    where Output == Target {
        contramap { replacement in isomorphism.backward(copy replacement) }
    }
}
